#lang racket

(require racklog)

;; predykat unarny %male reprezentuje zbiór mężczyzn
(define %male
  (%rel ()
        [('adam)]
        [('john)]
        [('joshua)]
        [('mark)]
        [('david)]))

;; predykat unarny %female reprezentuje zbiór kobiet
(define %female
  (%rel ()
        [('eve)]
        [('helen)]
        [('ivonne)]
        [('anna)]))

;; predykat binarny %parent reprezentuje relację bycia rodzicem
(define %parent
  (%rel ()
        [('adam 'helen)]
        [('adam 'ivonne)]
        [('adam 'anna)]
        [('eve 'helen)]
        [('eve 'ivonne)]
        [('eve 'anna)]
        [('john 'joshua)]
        [('helen 'joshua)]
        [('ivonne 'david)]
        [('mark 'david)]))

;; predykat binarny %sibling reprezentuje relację bycia rodzeństwem
(define %sibling
  (%rel (a b c)
        [(a b)
         (%parent c a)
         (%parent c b)]))

;; predykat binarny %sister reprezentuje relację bycia siostrą
(define %sister
  (%rel (a b)
        [(a b)
         (%sibling a b)
         (%female a)]))

;; predykat binarny %ancestor reprezentuje relację bycia przodkiem
(define %ancestor
  (%rel (a b c)
        [(a b)
         (%parent a b)]
        [(a b)
         (%parent a c)
         (%ancestor c b)]))

;; Zadanie 1

(define %grandson
  (%rel (a b c)
        [(a b)
         (%male a)
         (%parent c a)
         (%parent b c)]))

(define %cousin
  (%rel (a b c d)
        [(a b)
         (%parent c a)
         (%parent d b)
         (%sibling c d)]
        [(a b)
         (%parent c a)
         (%parent d b)
         (%cousin c d)]))

(define %is-mother
  (%rel (a b)
        [(a)
         (%female a)
         (%parent a b)]))

(define %is-father
  (%rel (a b)
        [(a)
         (%male a)
         (%parent a b)]))

;; Zadanie 2

(%find-all () (%ancestor 'john 'mark))
(%find-all (a) (%ancestor a 'adam))
(%find-all (a) (%sister a 'ivonne))
(%find-all (a b) (%cousin a b))


;--------------
(define %begins
  (%rel (x y xs ys)
        [(null ys)]
        [((cons x xs) (cons y ys))
         (%is x y)
         (%begins xs ys)]))

(define %sublist
  (%rel (x xs ys)
        [(null ys)]
        [((cons x xs) (cons x ys))
         (%sublist xs ys)]
        [(xs (cons x ys))
         (%sublist xs ys)]))

(define %select
  (%rel (x xs y ys)
        [(x (cons x xs) xs)]
        [(y (cons x xs) (cons x ys))
         (%select y xs ys)]))
(define %remove
  (%rel (x xs ys zs as)
        [(null ys ys)]
        [((cons x xs) ys as)
         (%select x ys zs)
         (%remove xs zs as)]))

(define %rest
  (%rel (xs ys zs)
        [(xs ys zs)
         (%sublist xs ys)
         (%remove xs ys zs)]))

(define %stars
  (%rel (n m x xs)
        [(1 '(*))]
        [(n (cons x xs))
         (%is m (- n 1))
         (%is x '*)
         (%stars m xs)]))