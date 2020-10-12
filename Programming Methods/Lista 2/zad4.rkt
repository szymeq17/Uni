#lang racket

(define (square x) (* x x))
(define (inc x) (+ x 1))
(define (f1 x) (/ 1 x))
(define (product val next start end)
  (if (> start end)
      1
      (* (val start)
         (product val next (next start) end))))

(define (product-it val next start end)
  (define (iter start result)
    (if (= start end)
        result
        (iter (+ start 1) (* result
                           (val (next start))))))
  (iter start (val start)))

;(product inc f1 1 4)
;(product-it f1 inc 1 4)

;wyliczanie pi
(define (inc2 x) (+ x 2))
;(* 2
;   (/ (product square inc2 2.0 20)
;      (product square inc2 3.0 20)))
(product square inc2 2.0 4)