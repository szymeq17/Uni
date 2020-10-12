#lang racket

(struct const (val)    #:transparent)
(struct binop (op l r) #:transparent)

; 2 + 2 * 2
(define 2+2*2 (binop '+ (const 2)
                        (binop '* (const 2)
                                  (const 2))))

; Co to są wyrażenia?
(define (expr? e)
  (match e
    [(const n) (number? n)]
    [(binop op l r) (and (symbol? op) (expr? l) (expr? r))]
    [_ false]))

; Co to są wartości?
(define (value? v)
  (number? v))

(define (op->proc op)
  (match op ['+ +] ['- -] ['* *] ['/ /]))

(define (eval e)
  (match e
    [(const n) n]
    [(binop op l r) ((op->proc op) (eval l) (eval r))]))

; ------------------------- ;
; Trochę składni konkretnej ;
; ------------------------- ;

(define (parse q)
  (cond [(number? q) (const q)]
        [(and (list? q) (eq? (length q) 3) (symbol? (first q)))
         (binop (first q) (parse (second q)) (parse (third q)))]))


(define (pretty-printer e)
  (define (to-infix e string)
    (match e
      [(const n) (string-append string (number->string n))]
      [(binop op l r) (string-append string
                                     "("
                                     (to-infix l string)
                                     " "
                                     (symbol->string op)
                                     " "
                                     (to-infix r string)
                                     ")")]))
  (to-infix e ""))

#|
(pretty-printer 2+2*2)
(pretty-printer (parse '(- (* 2 30) (+ 3 (* 8 5)))))
(pretty-printer (parse '(/ (* 2 4) (- 2 4))))
|#

(pretty-printer (binop '- (binop '+ (const 2) (const 1)) (binop '+ (const 4) (const 5))))










   