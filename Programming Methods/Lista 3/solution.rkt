#lang racket
(provide partition quicksort)

(define (partition xs n)
  (define (iter i L1 L2)
    (if (= i (length xs))
        (cons L1 L2)
        (let ([item (list-ref xs i)])    
          (if (> item n)
              (iter (+ i 1) L1 (append L2 (list item)))
              (iter (+ i 1) (append L1 (list item)) L2)))))
  (iter 0 (list) (list)))

(define (quicksort xs)
  (if (or (null? xs) (null? (cdr xs)))
      xs
      (let ([pivot (partition xs (list-ref xs 0))]) ;dzielenie względem pierwszego elementu
        (append (quicksort (cdr (car pivot)))
                (list (car (car pivot)))
                (quicksort (cdr pivot))))))

(quicksort (list 1 0 1 0 1 0))
(quicksort (list 1 2 3 4 5))
(quicksort (list 5 4 3 2 1))
(quicksort (list -1 -2 -3 1 2 3))
(quicksort (list))
(quicksort (list 1))

