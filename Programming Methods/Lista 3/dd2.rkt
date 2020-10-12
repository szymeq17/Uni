#lang racket
(define (append xs ys)
  (if (null? xs)
      ys
      (cons (car xs)
            (append (cdr xs) ys))))

(define (filter p? xs)
  (if (null? xs)
      null
      (if (p? (car xs))
          (cons (car xs)
                (filter p? (cdr xs)))
          (filter p? (cdr xs)))))

Teza: (filter p? (append xs ys)) ?= (append (filter p? xs) (filter p? ys))

Dowód indukcyjny względem xs:

L = (filter p? (append xs ys)) = ;z def. append
= (filter p?
          (if (null? xs)
           ys
           (cons (car xs)
                 (append (cdr xs) ys))))

P = (append (filter p? xs) (filter p? ys)) = ;z def. filter
= (append (if (null? xs)
              ys
              (cons (car xs)
                    (append (cdr xs) ys)))
          (filter p? ys))

Podstawa indukcji: (null? xs)

Jeśli xs jest nullem to z definicji append i filter mamy:

L = (filter p?
            (if #t
                ys
                (cons (car xs)
                      (append (cdr xs) ys)))) =
= (filter p? ys)

P = (append (if #t
                null
                (cons (car xs)
                      (append (cdr xs) ys)))
            (filter p? ys)) =
= (append null (filter p? ys)) = ;korzystając z poprzedniego dowodu
= (append (filter p? ys))

Zatem L = P

Krok indukcyjny: Załóżmy, że dla dowolnych x, xs zachodzi:

(filter p? (append xs ys)) = (append (filter p? xs) (filter p? ys))

Niech L = (filter p? (append (cons x xs) ys)) a P = (append (filter p? (cons x xs)) (filter p? ys))
Pokażemy, że zachodzi L = P

L = (filter p? (append (cons x xs) ys)) = ;z def. append
= (filter p?
          (if (null? (cons x xs))
              ys
              (cons (car (cons x xs))
                    (append (cdr (cons x xs)) ys)))) = (filter p? (cons x (append xs ys))) = ;z def. filter i własności if
= (if (p? (car (cons x (append xs ys))))
      (cons (car (cons x (append xs ys)))
            (filter p? (cdr (cons x (append xs ys))))
      (filter p? (cdr xs))))

Przypadek 1 (L1) - zachodzi (p? (car (cons x (append xs ys)))

L1 = (cons x (filter p? (append xs ys))) = ;z zał. ind.
= (cons x (append (filter p? xs) (filter p? ys)))

Przypadek 2 (L2) - nie zachodzi (car (cons x (append xs ys)))

L2 = (filter p? (cdr (cons x (append xs ys)))) = ;z własności cdr
= (filter p? (append xs ys)) = ;z zał. ind.
= (append (filter p? xs) (filter p? ys))


P = (append (filter p? (cons x xs)) (filter p? ys)) = ;z def. filter i własności if
= (append (if (p? (car (cons x xs)))
              (cons (car (cons x xs))
                    (filter p? (cdr (cons x xs)))
              (filter p? (cdr (cons x xs)))))
          (filter p? ys))

Przypadek 1 (P1) - zachodzi (p? (car cons x xs))

P1 = (append ((cons x (filter p? xs)) (filter p? ys))) =
= (cons x (append (filter p? xs) (filter p? ys)))

Przypadek 2 (P2) - nie zachodzi (p? (car cons x xs))

P2 = (append (filter p? (cdr (cons x xs))) (filter p? ys)) =
= (append (filter p? xs) (filter p? ys))

Widzimy, że L1 = P1, a L2 = P2, więc L = P,
co kończy dowód
              


   