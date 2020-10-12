#lang racket

(provide (struct-out const) (struct-out binop) rpn->arith)
;; -------------------------------
;; Wyrazenia w odwr. not. polskiej
;; -------------------------------

(define (rpn-expr? e)
  (and (list? e)
       (pair? e)
       (andmap (lambda (x) (or (number? x) (member x '(+ - * /))))
               e)))

;; ----------------------
;; Wyrazenia arytmetyczne
;; ----------------------

(struct const (val)    #:transparent)
(struct binop (op l r) #:transparent)

(define (arith-expr? e)
  (match e
    [(const n) (number? n)]
    [(binop op l r)
     (and (symbol? op) (arith-expr? l) (arith-expr? r))]
    [_ false]))

;; ----------
;; Kompilacja
;; ----------
(struct stack (xs))

(define empty-stack (stack null))
(define (empty-stack? s) (null? (stack-xs s)))
(define (top s) (car (stack-xs s)))
(define (push a s) (stack (cons a (stack-xs s))))
(define (pop s) (stack (cdr (stack-xs s))))

(define (rpn->arith e)
  (define (rpn-helper e stack)
    (cond [(null? e) (top stack)]
          [(number? (car e))
           (rpn-helper (cdr e) (push (const (car e)) stack))]
          [(symbol? (car e))
           (let* ([arg-r (top stack)]
                  [stack (pop stack)]
                  [arg-l (top stack)]
                  [stack (pop stack)])
             (rpn-helper (cdr e) (push (binop (car e) arg-l arg-r) stack)))]))
  (rpn-helper e empty-stack))
         

(rpn->arith '(2 1 + 4 5 + -))
(rpn->arith '(5 3 2 * -))
(rpn->arith '(15 3 2 + /))