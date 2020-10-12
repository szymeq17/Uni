#lang racket
(require racket/contract)
;WSPÓŁPRACA: SZYMON RYSZ, DAWID DUDEK

(provide (contract-out
          [with-labels with-labels/c]
          [foldr-map foldr-map/c]
          [pair-from pair-from/c]))

(provide with-labels/c foldr-map/c pair-from/c)

"ZADANIE1"
(define with-labels/c (parametric->/c [a b] (->  (-> a b) (listof a) (listof (list/c b a)))))

(define (with-labels f xs)
    (define (tmp f xs acc)
        (if (null? xs)
            acc
            (tmp f (cdr xs) (append (list (list (f (car xs) ) (car xs) )) acc))))
    (reverse (tmp f xs '() )))

(with-labels number->string (list 1 2 3))

"ZADANIE 2"

(define foldr-map/c (parametric->/c [a b c] (-> (-> a b (cons/c c b) ) b (listof a) (cons/c (listof c) b)  )))

(define (foldr-map f a xs)
  (define (it a xs ys)
    (if (null? xs)
       (cons ys a) 
       (let[(p (f (car xs) a))]
         (it (cdr p) (cdr xs) (cons (car p) ys)))))
  (it a (reverse xs) null))

(foldr-map (lambda (x a) (cons a (+ a x))) 0' (1 2 3))

"ZADANIE 3"
(define pair-from/c (parametric->/c [a b c] (-> (-> a b) (-> a c) (-> a (cons/c b c) ))))

(define (pair-from f g)
    (lambda (x) (cons (f x) (g x))))

((pair-from (lambda (x) (+ x 1)) (lambda (x) (* x 2))) 2)