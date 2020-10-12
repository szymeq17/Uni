#lang racket

(define (filter p? xs)
  (if (null? xs)
      null
      (if (p? (car xs))
          (cons (car xs)
                (filter p? (cdr xs)))
          (filter p? (cdr xs)))))

(define (map f xs)
  (if (null? xs)
      null
      (cons (f (car xs))
            (map f (cdr xs)))))

(define (accumulate op nval xs)
  (if (null? xs)
      nval
      (op (car xs)
          (accumulate op nval (cdr xs)))))

(define (concat-map f xs)
  (if (null? xs)
      null
      (append (f (car xs))
              (concat-map f (cdr xs)))))
(define (from-to start end)
  (if (> start end)
      null
      (cons start (from-to (+ start 1) end))))

(define (adjoin-position row col rest)
  (append rest (list row col)))



#|
(define(queens  board-size)
  (define (empty-board)
    (list))
  (define (adjoin-position row col rest)
    )
  (define (safe? k positions)
    )
  (define (queen-cols k)
    (if (= k 0)
        (list (empty-board))
        (filter
         (lambda (positions) (safe? k positions))
         (concat-map
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (from-to 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))
|#