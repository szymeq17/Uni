#lang racket
(provide parse eval norm)
;;Skład grupy:
; - Szymon Rysz
; - Natalia Czerep
; - Dawid Dudek


;; Składnia abstrakcyjna
(struct const (val)                 #:transparent)
(struct var-expr (name)             #:transparent)
(struct let-expr (id bound body)    #:transparent)
(struct letrec-expr (id bound body) #:transparent)
(struct if-expr  (eb et ef)         #:transparent)
(struct lambda-expr (arg body)      #:transparent)
(struct app-expr (fun arg)          #:transparent)

(define (keyword s)
  (member s '(true false null and or if cond else lambda let letrec)))

(define (expr? e)
  (match e
    [(const n)           (or (number? n)
                             (boolean? n)
                             (null? n)
                             (string? n))]
    [(var-expr id)       (symbol? id)]
    [(let-expr x e1 e2 ) (and (symbol? x)
                              (expr? e1)
                              (expr? e2))]
    [(letrec-expr x e1 e2) (and (symbol? x)
                                (expr? e1)
                                (expr? e2))]
    [(if-expr eb et ef)  (and (expr? eb)
                              (expr? et)
                              (expr? ef))]
    [(lambda-expr x e)   (and (symbol? x)
                              (expr? e))]
    [(app-expr ef ea)    (and (expr? ef)
                              (expr? ea))]
    [_                   false]))

;; Parsowanie (zacytowane wyrażenie -> składnia abstrakcyjna)
(define (parse q)
  (cond
   [(number? q)     (const q)]
   [(string? q)     (const q)]
   [(eq? q 'true)   (const true)]
   [(eq? q 'false)  (const false)]
   [(eq? q 'null)   (const null)]
   [(and (symbol? q)
         (not (keyword q)))
    (var-expr q)]
   [(and (list? q)
         (= (length q) 3)
         (eq? (first q) 'let)
         (list? (second q))
         (= (length (second q)) 2)
         (symbol? (first (second q))))
    (let-expr (first (second q))
              (parse (second (second q)))
              (parse (third q)))]
   [(and (list? q)
         (= (length q) 3)
         (eq? (first q) 'letrec)
         (list? (second q))
         (= (length (second q)) 2)
         (symbol? (first (second q))))
    (letrec-expr (first (second q))
                 (parse (second (second q)))
                 (parse (third q)))]
   [(and (list? q)
         (= (length q) 4)
         (eq? (first q) 'if))
    (if-expr (parse (second q))
             (parse (third q))
             (parse (fourth q)))]
   [(and (list? q)
         (pair? q)
         (eq? (first q) 'and))
    (desugar-and (map parse (cdr q)))]
   [(and (list? q)
         (pair? q)
         (eq? (first q) 'or))
    (desugar-or (map parse (cdr q)))]
   [(and (list? q)
         (>= (length q) 2)
         (eq? (first q) 'cond))
    (parse-cond (cdr q))]
   [(and (list? q)
         (= (length q) 3)
         (eq? (first q) 'lambda)
         (list? (second q))
         (andmap symbol? (second q))
         (cons? (second q)))
    (desugar-lambda (second q) (parse (third q)))]
   [(and (list? q)
         (>= (length q) 2))
    (desugar-app (parse (first q)) (map parse (cdr q)))]
   [else (error "Unrecognized token:" q)]))

(define (parse-cond qs)
  (match qs
    [(list (list 'else q))
     (parse q)]

    [(list (list q _))
     (error "Expected 'else' in last branch but found:" q)]

    [(cons (list qb qt) qs)
     (if-expr (parse qb) (parse qt) (parse-cond qs))]))

(define (desugar-and es)
  (if (null? es)
      (const true)
      (if-expr (car es) (desugar-and (cdr es)) (const false))))

(define (desugar-or es)
  (if (null? es)
      (const false)
      (if-expr (car es) (const true) (desugar-or (cdr es)))))

(define (desugar-lambda xs e)
  (if (null? xs)
      e
      (lambda-expr (car xs) (desugar-lambda (cdr xs) e))))

(define (desugar-app e es)
  (if (null? es)
      e
      (desugar-app (app-expr e (car es)) (cdr es))))

;; Środowiska
(struct blackhole ())
(struct environ (xs))

(define env-empty (environ null))
(define (env-add x v env)
  (environ (cons (mcons x v) (environ-xs env))))
(define (env-lookup x env)
  (define (assoc-lookup xs)
    (cond [(null? xs)
           (error "Unknown identifier" x)]
          [(eq? x (mcar (car xs)))
           (let ((v (mcdr (car xs))))
             (if (blackhole? v)
                 (error "Jumped into blackhole at" x)
                 v))]
          [else (assoc-lookup (cdr xs))]))
  (assoc-lookup (environ-xs env)))
(define (env-update! x v env)
  (define (assoc-update xs)
    (cond [(null? xs) (error "Unknown identifier" x)]
          [(eq? x (mcar (car xs)))
           (set-mcdr! (car xs) v)]
          [else (assoc-update (cdr xs))]))
  (assoc-update (environ-xs env)))

;; Domknięcia
(struct clo (arg body env))

;; Procedury wbudowane, gdzie
;; proc — Racketowa procedura którą należy uruchomić
;; args — lista dotychczas dostarczonych argumentów
;; pnum — liczba brakujących argumentów (> 0)
;; W ten sposób pozwalamy na częściową aplikację Racketowych procedur
;; — zauważmy że zawsze znamy pnum, bo w naszym języku arność
;; procedury jest ustalona z góry
(struct builtin (proc args pnum) #:transparent)

;; Pomocnicze konstruktory procedur unarnych i binarnych
(define (builtin/1 p)
  (builtin (lambda (x) (return (p x))) null 1))
(define (builtin/2 p)
  (builtin (lambda (x y) (return (p x y))) null 2))

;; Procedury
(define (proc? v)
  (or (and (clo? v)
           (symbol?  (clo-arg v))
           (expr?    (clo-body v))
           (environ? (clo-env v)))
      (and (builtin? v)
           (procedure? (builtin-proc v))
           (andmap value? (builtin-args v))
           (natural? (builtin-pnum v))
           (> (builtin-pnum v) 0))))

;; Definicja typu wartości
(define (value? v)
  (or (number? v)
      (boolean? v)
      (null? v)
      (string? v)
      (and (cons? v)
           (value? (car v))
           (value? (cdr v)))
      (proc? v)))
;;-----------------------------------------
(define (uniform xs)
  (define (go xs n)
    (if (null? xs)
        null
        (cons (cons (/ 1 n) (car xs)) (go (cdr xs) n))))
  (go xs (length xs)))
;------------------------------------------
;; Środowisko początkowe (przypisujące procedury wbudowane ich nazwom)
;; Efekt

(define (effect-builtin/1 p)
  (builtin p null 1))
(define (effect-builtin/2 p)
  (builtin p null 2))
(define (effect-builtin/3 p) ; <-------------------------------- new
  (builtin p null 3))


(define start-env
  (foldl (lambda (p env) (env-add (first p) (second p) env))
         env-empty
         `((+        ,(builtin/2 +))
           (-        ,(builtin/2 -))
           (*        ,(builtin/2 *))
           (/        ,(builtin/2 /))
           (~        ,(builtin/1 -))
           (<        ,(builtin/2 <))
           (>        ,(builtin/2 >))
           (=        ,(builtin/2 =))
           (<=       ,(builtin/2 <=))
           (>=       ,(builtin/2 >=))
           (not      ,(builtin/1 not))
           (cons     ,(builtin/2 cons))
           (car      ,(builtin/1 car))
           (cdr      ,(builtin/1 cdr))
           (pair?    ,(builtin/1 cons?))
           (null?    ,(builtin/1 null?))
           (boolean? ,(builtin/1 boolean?))
           (number?  ,(builtin/1 number?))
           (procedure? ,(builtin/1 (lambda (x) (or (clo? x) (builtin? x)))))
           (string?  ,(builtin/1 string?))
           (string-= ,(builtin/2 string=?))
           (uniform  ,(effect-builtin/1 uniform)); <----------------------------- new
           ;; and so on, and so on
           )))


           
(define prob-env
  (foldl (lambda (p env) (env-add (first p) (second p) env))
         start-env
         `((flip ,(effect-builtin/3 (lambda (p x y) (list (cons p x)
                                                          (cons (- 1 p) y)))))))) ; <------- new

;Zedytowane bind i return oraz procedura pomocnicza mult-prob
;----------------------------------------------------------------------------------
(define (mult-prob pairs p)
    (if (null? pairs)
        null
        (cons (cons (* p (caar pairs)) (cdar pairs)) (mult-prob (cdr pairs) p))))

(define (bind c k)
    (if (null? c)
        null
        (append (mult-prob (k (cdar c)) (caar c)) (bind (cdr c) k))))
        


(define (return x) (list (cons 1 x)))
;----------------------------------------------------------------------------------
;Procedura norm
;----------------------------------------------------------------------------------
(define (sort-by-second xs)
  (sort xs
        (lambda (x y) (< (cdr x) (cdr y)))))

(define (norm pairs)
  (define (go pairs first n acc)
    (if (null? (cdr pairs))
        (cons (cons n first) acc)
        (let ([next (car (cdr pairs))])
          (if (eq? first (cdr next))
              (go (cdr pairs) first (+ n (car next)) acc)
              (go (cdr pairs) (cdr next) (car next) (cons (cons n first) acc))))))   
  (let ([sorted (sort-by-second pairs)])
    (go sorted (cdar sorted) (caar sorted) '()))  
   
(go (sort-by-second pairs) (cdar (sort-by-second pairs)) (caar pairs) '()))
;----------------------------------------------------------------------------------
;; Ewaluator
(define (eval-env e env)
  (match e
    [(const n)
     (return n)]

    [(var-expr x)
     (return (env-lookup x env))]

    [(let-expr x e1 e2)
     (bind (eval-env e1 env) (lambda (v1)
       (eval-env e2 (env-add x v1 env))))]

    [(letrec-expr f ef eb)
     (let ((new-env (env-add f (blackhole) env)))
     (bind (eval-env ef new-env) (lambda (vf)
       (env-update! f vf new-env)
       (eval-env eb new-env))))]

    [(if-expr eb et ef)
     (bind (eval-env eb env) (lambda (vb) 
     (match vb
       [#t   (eval-env et env)]
       [#f   (eval-env ef env)]
       [v    (error "Not a boolean:" v)])))]

    [(lambda-expr x e)
     (return (clo x e env))]
    

    [(app-expr ef ea)
     (bind (eval-env ef env) (lambda (vf)
     (bind (eval-env ea env) (lambda (va)
       (match vf
         [(clo x e env)
          (eval-env e (env-add x va env))]
         [(builtin p args nm)
          (if (= nm 1)
              (apply p (reverse (cons va args)))
              (return (builtin p (cons va args) (- nm 1))))]
         [_ (error "Not a function:" vf)])))))]))

(define (eval e)
  (eval-env e prob-env))


;; Przykladowy program

(define PROGRAM
  '((if (choose true false) (lambda (x) x) (lambda (x) (+ x 1))) (choose 1 2)))


;; REPL — interpreter interaktywny (read-eval-print loop)

;; dodajemy składnię na wiązanie zmiennych "na poziomie interpretera"
;; i komendę wyjścia "exit" ...
(struct letrec-repl (id expr))
(struct let-repl (id expr))
(struct exit-repl ())

;; ... a także rozszerzoną procedurę parsującą te dodatkowe komendy i
;; prostą obsługę błędów
(define (parse-repl q)
  (with-handlers
      ([exn? (lambda (exn)
                 (display "Parse error! ")
                 (displayln (exn-message exn)))])
    (cond
     [(eq? q 'exit)   (exit-repl)]
     [(and (list? q)
           (= 3 (length q))
           (eq? (first q) 'let))
      (let-repl (second q) (parse (third q)))]
     [(and (list? q)
           (= 3 (length q))
           (eq? (first q) 'letrec))
      (letrec-repl (second q) (parse (third q)))]
     [else (parse q)])))

;; trochę zamieszania w procedurze eval-repl wynika z rudymentarnej
;; obsługi błędów: nie chcemy żeby błąd w interpretowanym programie
;; kończył działanie całego interpretera!
(define (eval-repl c env continue)
  (define (eval-with-err e env)
    (with-handlers
        ([exn? (lambda (exn)
                 (display "Error! ")
                 (displayln (exn-message exn)))])
      (eval-env e env)))
  (match c
    [(exit-repl)
     (void)]

    [(let-repl x e)
     (let ((v (eval-with-err e env)))
       (if (void? v)
           (continue env)
           (continue (env-add x v env))))]

    [(letrec-repl f e)
     (let* ((new-env (env-add f (blackhole) env))
            (v       (eval-with-err e new-env)))
       (if (void? v)
           (continue env)
           (begin
             (env-update! f v new-env)
             (continue new-env))))]

    [_
     (let ((v (eval-with-err c env)))
       (unless (void? v)
         (displayln v))
       (continue env))]))

;; I w końcu interaktywny interpreter
(define (repl)
  (define (go env)
    (display "FUN > ")
    (let* ((q (read))
           (c (parse-repl q)))
      (if (void? c)
          (go env)
          (eval-repl c env go))))
  (displayln "Welcome to the FUN functional language interpreter!")
  (go prob-env))

(define TWO-DICE
  '(letrec [from-to (lambda (x n)
                      (cons x
                            (if (= x n)
                                null
                                (from-to  (+ 1 x) n))))]
     (let     [dice1 (uniform (from-to 1 6))]
       (let     [dice2 (uniform (from-to 1 6))]
         (+  dice1  dice2)))))

(define COIN-DICE'
  (letrec [from-to (lambda (x n)
                     (cons x
                           (if (= x n)
                               null
                               (from-to  (+ 1 x) n))))]
    (let     [dice (lambda (x) (uniform (from-to 1 6)))]
      (if (flip  0.5  true  false)
          (dice  false)
          (+ (dice  false) (dice  false))))))




(define DICE-MANY
   '(letrec [from-to (lambda (x n)
                     (cons x
                           (if (= x n)
                               null
                               (from-to (+ 1 x) n))))]
    (let [dice (lambda (x) (uniform (from-to 1 6)))]
        (letrec [n-times (lambda (n)
                          (letrec [helper (lambda (n acc)
                                              (if (= n 0)
                                                  acc
                                                  (helper (- n 1) (+ acc (dice 0)))))]
                                 (helper n 0)))]
        (let [sum-dice (lambda (k1)
                            (n-times k1))]
                                
        (let [result (sum-dice (dice 0))]
            result))))))

;; Testy:

(eval (parse'(uniform (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 (cons 6 null)))))))))
(eval (parse'(if (flip  0.3  true  false) "wygrana" "przegrana")))
(eval (parse
       '(if (flip  0.3  true  false)
            (if (flip  0.3  true  false)
                "wygrana"
                "przegrana")
            "przegrana")))

(norm (eval (parse TWO-DICE)))
(norm (eval (parse TWO-DICE)))
(norm (eval (parse DICE-MANY)))