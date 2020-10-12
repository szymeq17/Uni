#lang racket

(define (reverse-rec items)
  (if (= (length items) 1)
      items
      (append (reverse-rec (cdr items)) (list (car items)))))

(define L (list 1 2 3 4))

(define (reverse x)
  (define (reverse-iter counter new_list)
    (if (= counter (length x))
        new_list
        (reverse-iter (+ 1 counter)
                      (append (list (list-ref x counter) ) new_list))
        ))
  (reverse-iter 0 (list)))

(reverse-rec L)
L