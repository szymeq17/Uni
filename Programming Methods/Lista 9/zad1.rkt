#lang racket

(define (lcons x f) (mcons x f))
(define lnull  null)
(define lnull? null?)
(define (lcar xs) (mcar xs))
(define (lcdr xs) ((mcdr xs)))
(define (lcar-set! xs v) (mcar-set! xs v))
(define (lcdr-set! xs v) (mcdr-set! xs v))

(define (lnth n xs)
  (cond [(= n 0) (lcar xs)]
        [else
         (begin (lcar-set! xs (lcar xs))
                (lnth (- n 1) (lcdr xs)))]))
(define (lfilter p xs)
  (cond [( lnull? xs) lnull]
        [(p (lcar xs))
         (lcons (lcar xs) (lambda() (lfilter p (lcdr xs))))][else(lfilter p (lcdr xs))]))

(define (from n) (lcons n (lambda() (from (+ n 1)))))

(define nats (from 0))
(lnth 10 nats)