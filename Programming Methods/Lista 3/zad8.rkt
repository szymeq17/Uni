#lang racket
(provide merge split mergesort)

(define (merge L1 L2)
  (cond [(null? L1) L2]
        [(null? L2) L1]
        [(< (car L1) (car L2))
         (cons (car L1) (merge (cdr L1) L2))]
        [else (cons (car L2) (merge L1 (cdr L2)))]))

(define (split L)
  (define (helper i xs ys)
    (if (= i (length L))
        (cons xs ys)
        (if (< i (ceiling (/ (length L) 2)))
            (helper (+ i 1) (append xs (list (list-ref L i))) ys)
            (helper (+ i 1) xs (append ys (list (list-ref L i)))))))
  (helper 0 (list) (list)))

(define (mergesort L)
  (if (or (null? L) (null? (cdr L)))
      L
      (merge (mergesort (car (split L))) (mergesort (cdr (split L))))))

(mergesort (list 5 4 3 2 1))
(mergesort (list 1 2 3 4 5))
(mergesort (list 1 0 1 0 1))
(mergesort (list -1 -2 -3 1 2 3))
(mergesort (list 1))
(mergesort (list))
