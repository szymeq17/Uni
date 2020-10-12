#lang racket
; sqrt pierwiastek
; expt potęga
;ZADANIE 1
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
  (display "]")
  (newline))

(define (point-x x) (car x))
(define (point-y x) (cdr x))

(define (point? x)
  (and (cons? x)
       (number? (car x))
       (number? (cdr x))))

(define (make-point x y)
  (cons x y))

(define (make-vect p1 p2)
  (cons p1 p2))

(define (vect? x)
  (and (cons? x)
       (point? (car x))
       (point? (cdr x))))

(define (vect-begin x)
  (car x))

(define (vect-end x)
  (cdr x))

(define (vect-length v)
  (sqrt (+ (expt (- (point-x (vect-begin v)) (point-x (vect-end v))) 2)
           (expt (- (point-y (vect-begin v)) (point-y (vect-end v))) 2))))

(define (vect-scale v k)
  (make-vect (vect-begin v) (make-point (* k (point-x (vect-end v))) (* k (point-y (vect-end v))))))

(define (vect-translate v p)
  (make-vect p (make-point (+ (point-x p) (point-x (vect-end v))) (+ (point-y p) (point-y(vect-end v))))))


(define p1
  (make-point 0 0))

(define p2
  (make-point 1 1))

(define p3
  (make-point 4 0))

(define p4
  (make-point 2 2))

(define v1
  (make-vect p1 p2))

(display-vect v1)

(vect-length
 (make-vect p1 p2))

(display-vect (vect-scale v1 5))

(display-vect (vect-translate v1 (make-point 4 4)))


"ZADANIE 2"
; ZADANIE 2 - reprezentacja to [angle [vektor]]
(define (make-hooked-vector angle x len)
  (define (count-point)
    (let ([x1 (abs(- (point-x x)
                (* len (sin angle))))]
          [y1 (abs(- (point-y x)
                 (* len (cos angle))))])
    (make-point x1 y1)))
  (cons angle (make-vect x (count-point))))

(define (hooked-vector-angle v)
  (car v))
(define (hooked-vector-first-point v)
  (car (cdr v)))
(define (hooked-vector-second-point v)
  (cdr (cdr v)))


(define (display-hooked-vector v) ; wiem ze nie zamyka sie nawias ale w display-vecta mam newline i nie chcialo mi sie zmieniac
  (display "( ")
  (display (hooked-vector-angle v))
  (display " ")
  (display-vect (cdr v)))

(define (hooked-vector-len v)
  (vect-length (cdr v)))

(define (hooked-vector-scale v k)
  (make-hooked-vector (hooked-vector-angle v) (hooked-vector-first-point ) (* k (hooked-vector-len))))

(define (hooked-vector-translate v p)
  (make-hooked-vector (hooked-vector-angle) p (hooked-vector-len)))


(define hooked-vect1
  (make-hooked-vector 0.92 (make-point 0 0) 5))

(display-hooked-vector hooked-vect1)


"ZADANIE 3"
;ZADANIE 3

(define (reverse x)
  (define (reverse-iter counter new_list)
    (if (= counter (length x))
        new_list
        (reverse-iter (+ 1 counter)
                      (append (list (list-ref x counter) ) new_list))
        ))
  (reverse-iter 0 (list)))

(reverse (list 1 2 3 4 5))


(define (reverse-rec x)
  (if (= 1 (length x))
      x
      (append (reverse-rec (cdr x)) (list (car x)))))

(reverse-rec (list 1 2 3 4 5))

"ZADANIE 4"
;Zadanie 4
(define (insert xs n)
  (define (insert-iter counter new_list)
    (if (= (length new_list) (+ 1 (length xs)))
        new_list
        (cond
          [ (= counter (length xs) (length new_list)) (insert-iter counter (append new_list (list n)))] ; na wypadek n > x[i] dla kazdego i
          [ (>= n (list-ref xs counter)) (insert-iter (+ 1 counter) (append new_list (list (list-ref xs counter))))]
          [ (and (< n (list-ref xs counter)) (= counter (length new_list))) (insert-iter counter (append new_list (list n)))]
          [ else (insert-iter (+ 1 counter) (append new_list (list (list-ref xs counter))))])))
  (insert-iter 0 (list)))
                 
(define (insert-sort xs)
  (define (insert-sort-iter counter new_list)
    (if (= counter (length xs))
        new_list
        (insert-sort-iter (+ 1 counter) (insert new_list (list-ref xs counter))))) ; sprawdza gdzie ustawic dany element w nowo tworzonej tablicy
  (insert-sort-iter 1 (list)))


(insert (list 1 2 3 4 5 6) 7)

(insert-sort (list 4 3 2 10 12 1 5 6))

"ZADANIE 5"
; ZADANIE 5



   





    
      
  