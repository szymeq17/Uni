#lang racket
(provide lcons lnull lnull? lcar lcdr lnth)

(define (lcons x f) (mcons x f))
(define lnull  null)
(define lnull? null?)
(define (lcar xs) (mcar xs))
;=========================================================
;W przypadku lcdr musimy sprawdzić, czy mcdr listy
;mamy traktować jako wartość czy jako procedurę
(define (lcdr xs) (if (procedure? (mcdr xs))
                      (begin (set-mcdr! xs ((mcdr xs)))
                             (mcdr xs))
                      (mcdr xs)))
;=========================================================
(define (lnth n xs)
  (cond [(= n 0) (lcar xs)]
        [else (lnth (- n 1) (lcdr xs))]))

(define (lfilter p xs)
  (cond [(lnull? xs) lnull]
        [(p (lcar xs))
         (lcons (lcar xs) (lambda () (lfilter p (lcdr xs))))]
        [else (lfilter p (lcdr xs))]))

(define (prime? n)
  (define (factors i)
    (cond [(>= i n) (list n)]
          [(= (modulo n i) 0)
           (cons i (factors  (+ i 1)))]
          [else (factors (+ i 1))]))
  (= (length (factors  1)) 2))


(define (from n) (lcons n (lambda () (from (+ n 1)))))

(define primes (lfilter prime? (from 2)))


(let ([x (from 1)]) (begin (lcdr (lcdr x)) x))

;TESTY:

(time (lnth  1000  primes))
(time (lnth  1001  primes))
(time (lnth  1002  primes))


;TESTY v2:
#|
(define (sum n)
  (if (= n 0)
      0
      (+ n (sum (- n 1)))))

(define (sums from) (lcons (sum from) (lambda () (sums (+ from 1)))))
(define od-zera (sums 0))
(time (lnth 10000 od-zera))
(time (lnth 10001 od-zera))
(time (lnth 10002 od-zera))
|#