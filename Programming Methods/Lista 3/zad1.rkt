#lang racket

(define (make-vect a b) (cons a b))

(define (vect-begin x) (car x))
(define (vect-end x) (cdr x))

(define (vect? x)
  (and (point? (vect-begin x))
       (point? (vect-end x))))

(define (make-point x y) (cons x y))

(define (point? x)
  (and (cons? x)
   (number? (point-x x))
   (number? (point-y x))))

(define (point-x x) (car x))
(define (point-y x) (cdr x))

(define (display-point p)
  (display "(")
  (display (point-x p))
  (display ", ")
  (display (point-y p))
  (display ")"))

(define(display-vect v)
  (display "[")
  (display-point (vect-begin v))
  (display ", ")
  (display-point (vect-end v))
  (display "]"))

(define (do-wektor v)
  (make-point (- (point-x (vect-end v))
                                (point-x (vect-begin v)))
                             (- (point-y (vect-end v))
                                (point-y (vect-begin v)))))
;----------------------------------------
(define (vect-length x)
  (sqrt (+ (expt (- (point-x (vect-end x))
                    (point-x (vect-begin x))) 2)
           (expt (- (point-y (vect-end x))
                    (point-y (vect-begin x))) 2))))
(define (vect-scale v k)
  (let* ([wektor (make-point (- (point-x (vect-end v))
                                (point-x (vect-begin v)))
                             (- (point-y (vect-end v))
                                (point-y (vect-begin v))))]
         [k-wektor (make-point (* k (point-x wektor)) (* k (point-y wektor)))])
    (make-vect (vect-begin v) (make-point (+ (point-x k-wektor)
                                             (point-x (vect-begin v)))
                                          (+ (point-y k-wektor)
                                             (point-y (vect-begin v)))))))
;---------------------------------------------------------------------------------
(define (vect-translate v p)
  (let ([v1 (do-wektor v)])
    (make-vect p (make-point (+ (point-x v1)
                                 (point-x p))
                              (+ (point-y v1)
                                 (point-y p))))))        
;----------------------------------------
(define p (make-point 1 2))
(define q (make-point 3 4))
(define r (make-point 3 8))
(define weq (make-vect p q))
(display-vect weq)
(do-wektor weq)
(display-vect (vect-translate weq (make-point 3 10)))
(do-wektor (vect-translate weq (make-point 3 10)))