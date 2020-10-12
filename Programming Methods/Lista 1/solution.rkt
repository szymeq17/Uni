#lang racket
;Wzorowałem się na programie obliczającym sqrt z pierwszego wykładu
(provide cube-root)

;Funkcje pomocnicze:
(define (square x)
  (* x x))

(define (cube x)
  (* x x x))

(define (dist x y)
  (abs (- x y)))

;Główna funkcja:
(define (cube-root x)
  (define (improve guess)
    (/ (+ (* 2 guess)
          (/ x (square guess)))
       3))
  (define (good-enough? g)
    (< (dist x (cube g))
       0.00001))
  (define (iter guess)
    (if (good-enough? guess)
        guess
        (iter (improve guess))))
  (iter 1.0))

;Testy:

(cube-root 27)
(cube-root 0)
(cube-root -1)
(cube-root (cube 3.14))
