#lang racket

(define (square x) (* x x))
(define (inc x) (+ x 1))

(define (compose f g)
  (lambda (x) (f (g x))))
;((compose square inc) 5)
;;=((compose inc square) 5)

(define (repeated p n)
  (if (= n 0)
      (compose p p)
      (repeated p (- n 1))))

;((repeated square 2) 3)