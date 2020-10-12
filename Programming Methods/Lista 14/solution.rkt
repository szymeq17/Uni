#lang racket
;WSPÓŁPRACA SZYMON RYSZ, NATALIA CZEREP, DAWID DUDEK

(require racklog)

(provide solve)

;; transpozycja tablicy zakodowanej jako lista list
(define (transpose xss)
  (cond [(null? xss) xss]
        ((null? (car xss)) (transpose (cdr xss)))
        [else (cons (map car xss)
                    (transpose (map cdr xss)))]))

;; procedura pomocnicza
;; tworzy listę n-elementową zawierającą wyniki n-krotnego
;; wywołania procedury f
(define (repeat-fn n f)
  (if (eq? 0 n) null
      (cons (f) (repeat-fn (- n 1) f))))

;; tworzy tablicę n na m elementów, zawierającą świeże
;; zmienne logiczne
(define (make-rect n m)
  (repeat-fn m (lambda () (repeat-fn n _))))

;; predykat binarny
;; (%row-ok xs ys) oznacza, że xs opisuje wiersz (lub kolumnę) ys
;---------------------------------------------------------------------
(define %row-ok
  (%rel (x xs ys zs)
        [(null null)]
        [(null (cons '_ ys))
         (%row-ok null ys)]
        [((cons x xs) ys)
         (%count x ys zs 0)
         (%row-ok xs zs)]))

(define %count
  (%rel (n m x y xs ys acc acc2)
        [(0 null null acc)]
        [(0 (cons '_ xs) (cons '_ xs) acc)]
        [(n (cons '* xs) ys acc)
         (%not (%is n 0))
         (%is m (- n 1))
         (%is acc2 (+ acc 1))
         (%count m xs ys acc2)]
        [(n (cons '_ xs) ys 0)
         (%count n xs ys 0)]))

;---------------------------------------------------------------------        
;---------------------------------------------------------------------

;; funkcja rozwiązująca zagadkę
(define (solve rows cols)
  (define board (make-rect (length cols) (length rows)))
  (define tboard (transpose board))
  (define ret (%which (xss)
                      (%make-row rows board)
                      (%make-row cols tboard)
                      (%= xss board)
                      ))
  (and ret (cdar ret)))

(define %make-row
  (%rel (x xs y ys)
        [(null null)]
        [((cons x xs) (cons y ys))
         (%row-ok x y)
         (%make-row xs ys)]))
                     
;; testy
(equal? (solve '((2) (1) (1)) '((1 1) (2)))
        '((* *)
          (_ *)
          (* _)))

(equal? (solve '((2) (2 1) (1 1) (2)) '((2) (2 1) (1 1) (2)))
        '((_ * * _)
          (* * _ *)
          (* _ _ *)
          (_ * * _)))

(equal? (solve '((4) (6) (2 2) (2 2) (6) (4) (2) (2) (2))
               '((9) (9) (2 2) (2 2) (4) (4)))
        '((* * * * _ _)
          (* * * * * *)
          (* * _ _ * *)
          (* * _ _ * *)
          (* * * * * *)
          (* * * * _ _)
          (* * _ _ _ _)
          (* * _ _ _ _)
          (* * _ _ _ _)))

;; TODO: możesz dodać własne testy
(equal? (solve '((2 1 1) (1 2) (1 1 1)) '((1 1) (2) (1) (2) (1) (1) (1) ))
        '((* * _ * _ * _)
          (_ * _ * * _ _)
          (* _ * _ _ _ *)))

(equal? (solve '((2 1) (1 2) (1 )) '((1 1) (2) (0) (2) (1)))
        '((* * _ * _  )
          (_ * _ * *  )
          (* _ _ _ _  )))


