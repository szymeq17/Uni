#lang racket

(define (append xs ys)
  (if (null? xs)
      ys
      (cons (car xs)
            (append (cdr xs) ys))))

(define (map f xs)
  (if (null? xs)
      null
      (cons (f (car xs))
            (map f (cdr xs)))))

Teza: (map f (append xs ys)) ?= (append (map f xs) (map f ys))

Dowód indukcyjny względem xs:

L = (map f (append xs ys)) = ;z def append
= (map f
       (if (null? xs)
           ys
           (cons (car xs)
                 (append (cdr xs) ys))))

P = (append (map f xs) (map f ys)) = ;z def map
= (append
   (if (null? xs)
       null
       (cons (f (car xs))
             (map f (cdr xs))))
   (map f ys))

Podstawa indukcji: (null? xs)

Jeśli xs jest nullem to z definicji append i map mamy:

L = (map f(append xs ys)) =
= (map f
       (if #t
           ys
           (cons (car xs)
                 (append (cdr xs) ys)))) =
= (map f ys)

P = (append (map f xs) (map f ys)) =
= (append
   (if #t
       null
       (cons (f (car xs))
             (map f (cdr xs)))) = 
= (append null (map f ys)) = (map f ys) ;analogicznie, jak po lewej stronie

Zatem L = P

Krok indukcyjny: Załóżmy, że dla dowolnych x, xs zachodzi:

(map f (append xs ys)) = (append (map f xs) (map f ys))


Niech L = (map f (append (cons x xs) ys)) a P = (append (map f (cons x  xs)) (map f ys)).
Pokażemy, że zachodzi: L = P

L = (map f (append (cons x xs) ys)) =
(map f
     (if (null? (cons x xs))
         ys
         (cons (car (cons x xs))
               (append (cdr (cons x xs)) ys)))) = ;z własności predykatu null?, formy specjalnej i oraz funkcji car i cdr
= (map f (cons x (append xs ys))) =
= (if #f
      null
      (cons (f (car (cons x (append xs ys))))
            (map f (cdr (cons x (append xs ys)))))) =
= (cons (f x) (map f (append xs ys))) = ;z założenia ind.
= (cons (f x) (append (map f xs) (map f ys)))

P = (append (map f (cons x  xs)) (map f ys)) = ;z def. map
(append (if #f
            (cons (f (car (cons x xs)))
                  (map f (cdr (cons x xs)))))
        (map f ys)) =
(append (cons (f x) (map f xs)) (map f ys)) = ;z def. append
= (cons (car (cons (f x) (map f xs)))
        (append (cdr (cons (f x) (map f xs))) (map f ys))) =
= (cons (f x) (append (map f xs) (map f ys))) =  L
              co kończy dowód