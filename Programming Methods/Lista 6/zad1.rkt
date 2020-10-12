#lang racket

;a)
;Składnia konkretna: (zakładając, że operatory są binarne)
(+ (+ (/ 8 (+ 2 3))
      10)
   1)

;Składnia abstrakcyjna:
(struct const (val) #:transparent)
(struct binop (op l r) #:transparent)

(define a (binop '+ (binop '+ (binop '/ (const 8)
                                        (binop '+ (const 2)
                                                  (const 3)))
                              (const 10))
                    (const 1)))

;b)
;Składnia konkretna: (zakładając, że operatory są binarne)
(+ 1
   (+ 2
      (+ (* 3 4)
         5)))

;Składnia abstrakcyjna:
(define b (binop '+ (const 1)
                    (binop '+ (const 2)
                              (binop '+ (binop '* (const 3)
                                                  (const 4))
                                        (const 5)))))
b