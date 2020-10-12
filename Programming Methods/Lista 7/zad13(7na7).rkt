#lang racket
(provide (struct-out const) (struct-out binop) (struct-out var-expr) (struct-out let-expr) (struct-out var-dead) find-dead-vars)

;Skład grupy:
;- Szymon Rysz
;- Natalia Czerep
;- Jakub Przydatek

; --------- ;
; Wyrazenia ;
; --------- ;

(struct const    (val)      #:transparent)
(struct binop    (op l r)   #:transparent)
(struct var-expr (id)       #:transparent)
(struct var-dead (id)       #:transparent)
(struct let-expr (id e1 e2) #:transparent)

(define (expr? e)
  (match e
    [(const n) (number? n)]
    [(binop op l r) (and (symbol? op) (expr? l) (expr? r))]
    [(var-expr x) (symbol? x)]
    [(var-dead x) (symbol? x)]
    [(let-expr x e1 e2) (and (symbol? x) (expr? e1) (expr? e2))]
    [_ false]))

(define (parse q)
  (cond
    [(number? q) (const q)]
    [(symbol? q) (var-expr q)]
    [(and (list? q) (eq? (length q) 3) (eq? (first q) 'let))
     (let-expr (first (second q))
               (parse (second (second q)))
               (parse (third q)))]
    [(and (list? q) (eq? (length q) 3) (symbol? (first q)))
     (binop (first q)
            (parse (second q))
            (parse (third q)))]))


; ---------------------------------- ;
; Wyszukaj ostatnie uzycie zmiennych ;
; ---------------------------------- ;

(define env-empty          (set))
(define (env-add x env)    (set-add env x))
(define (env-lookup x env) (set-member? env x))

(define (free-vars-env e env)
  (match e
    [(const n) (set)]
    [(binop op l r)
     (set-union (free-vars-env l env)
                (free-vars-env r env))]
    [(let-expr x e1 e2)
     (set-union (free-vars-env e1 env)
                (free-vars-env e2 (env-add x env)))]
    [(var-expr x)
     (if (env-lookup x env)
         (set) (list->set (list x)))]))

(define (free-vars e)
  (set->list (free-vars-env e env-empty)))

                
(define (find-dead-vars e)
    (define (walk e vars)
        (match e
            [(const n) (const n)]
            [(binop op l r) 
             (binop op (walk l (append vars (free-vars r)))
                       (walk r vars))]
            [(let-expr id e1 e2) 
             (let ([e1-vars (append (remove id (free-vars e2)) vars)] ;dodajemy bez id
                   [e2-vars (remove id (remove-duplicates vars))]) ;usuwamy id
                   (let-expr id (walk e1 e1-vars) (walk e2 e2-vars)))]
            [(var-expr id)
             (if (eq? (member id vars) #f)
                 (var-dead id)
                 (var-expr id))]))
  (walk e null))

;Testy:
(find-dead-vars (let-expr 'x (const  3) (binop'+ (var-expr'x) (var-expr'x))))
(find-dead-vars (let-expr 'x (const  3) (binop'+ (var-expr'x) (let-expr 'x (const  5) (binop'+ (var-expr 'x)(var-expr 'x))))))
(find-dead-vars (parse '(let [x 5] (* (+ (+ x 5) (- x 2)) (let [x 4] (+ x 3)))))) 
(find-dead-vars (parse '(let [x 4] (let [y x] (* x x)))))
(find-dead-vars (parse '(let [y 1] (* (+ y (let [y y] y)) (* y y)))))
(find-dead-vars (parse '(let [y 3] (+ (- y (let [y 3] y)) (* y y)))))
(find-dead-vars (parse '(let [x 5] (+ (let [x 4] (+ x 1)) x))))
(find-dead-vars (parse '(let [x 5] (- x (let [x 4] (* x 1))))))
(find-dead-vars (parse '(let [x 1] (+ (let [x x] x) 1))))
(find-dead-vars (parse '(let (x 1)  (let (y x) (+ x x)))))
(find-dead-vars (parse '(let [x 1] (let [x x] (+ 5 x)))))
(find-dead-vars (parse '(let [x 1] (let [y x] (let [x (+ x  y)] (+ x y))))))
