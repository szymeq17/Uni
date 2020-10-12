#lang typed/racket
;SZKIELET ZADANIA 6 Z ĆWICZEŃ 
;WSPÓŁPRACA DAWID DUDEK, SZYMON RYSZ, JAKUB PRZYDATEK, PIOTR GUNIA
(provide parse typecheck)

; --------- ;
; Wyrazenia ;
; --------- ;
(define-type  EType (U'real'boolean))

(define-type Value  (U Real Boolean))
(define-predicate value? Value)

(define-type Expr   (U const binop var-expr let-expr if-expr))
(define-predicate expr? Expr)

(define-type Op     (U '+ '- '* '/ '= '> '>= '< '<= 'and 'or))
(define-predicate op? Op)

(struct const    ([val : Value])                            #:transparent)
(struct binop    ([op : Op] [l : Expr] [r : Expr])          #:transparent)
(struct var-expr ([id : Symbol])                            #:transparent)
(struct let-expr ([id : Symbol] [e1 : Expr] [e2 : Expr])    #:transparent)
(struct if-expr  ([eb : Expr] [et : Expr] [ef : Expr])      #:transparent)

(: parse (-> Any Expr))
(define (parse q)
  (match q
    [(? real? n) (const n)]
    ['true (const true)]
    ['false (const false)]
    [(? symbol? s) (var-expr s)]
    [(list (? symbol? 'let) (list (? symbol? x) expr) body)
     (let-expr x (parse expr) (parse body))]
    [(list 'if pred ifTrue ifFalse)
     (if-expr (parse pred) (parse ifTrue) (parse ifFalse))]
    [(list (? op? op) l r) (binop op (parse l) (parse r))]))

; ---------- ;
; Srodowiska ;
; ---------- ;

(define-type Env environ)
(struct environ ([xs : (Listof (Pairof Symbol (U EType #f)))]))

(: env-empty Env)
(define env-empty (environ null))

(: env-add (-> Symbol (U EType #f) Env Env))
(define (env-add x v env)
  (environ (cons (cons x v) (environ-xs env))))

(: env-lookup (-> Symbol Env (U EType #f)))
(define (env-lookup x env)
  (: assoc-lookup (-> (Listof (Pairof Symbol (U EType #f))) (U EType #f)))
  (define (assoc-lookup xs)
    (cond [(null? xs) #f]
          [(eq? x (car (car xs))) (cdr (car xs))]
          [else (assoc-lookup (cdr xs))]))
  (assoc-lookup (environ-xs env)))

(: typecheck (-> Expr (U EType #f)))
(define (typecheck expr)
  (: check (-> Expr Env (U EType #f)))
  (define (check expr env)
    (match expr
      [(const n) (if (boolean? n) 'boolean 'real) ]
      [(var-expr x) (env-lookup x env)]
      [(binop op l r)  (let ([type-l (check l env)]
                             [type-r (check r env)])
                             (if (member op '(and or))
                                 (if (and (eq? type-l 'boolean)
                                          (eq? type-r 'boolean))
                                      'boolean
                                      #f)
                                 (if (member op '(< <= = >= >))
                                     (if (and (eq? type-l 'real)
                                              (eq? type-r 'real))
                                         'boolean
                                         #f)
                                     (if (and (eq? type-l 'real)
                                              (eq? type-r 'real))
                                         'real
                                         #f))))]
                                
    [(if-expr eb et ef) (if (eq? 'boolean (check eb env))
                              (let ([type-t (check et env)]
                                    [type-f (check ef env)])
                                    (if (eq? type-t type-f)
                                        type-t
                                        #f))                           
                              #f)]
      
      [(let-expr x e1 e2)
       (let ([type-e1 (check e1 env)])
         (if (eq? type-e1 #f)
             #f
             (check e2 (env-add x (check e1 env) env))))]))
  (check expr env-empty))

(typecheck (parse '(+ 2 3)))
(typecheck (parse '(let (x (+ 2 3)) (* 2 x))))
(typecheck (parse '( if (> 2 1) true true)))
(typecheck (parse '( if (> 2 1) 1 true)))
(typecheck (parse '(let (x false) (* 2 x))))
(typecheck (parse '(< true false)))
(typecheck (parse '(let [y (let [x (and false (= 1 2))] x)] (or y true))))
