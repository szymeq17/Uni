#lang racket
(provide nth-root)

;WE WSPÓŁPRACY Z:
;Michał Sobecki

;FUNKCJE POMOCNICZE:
(define (repeat p n)
  (if (= n 0)
      (identity p)
      (compose p (repeat p (- n 1)))))
(define (average x y)
  (/ (+ x y) 2))
(define (close-to? x y)
  (< (abs (- x y)) 0.0001))
(define (fixed-point s f)
  (if (close-to? s (f s))
      s
      (fixed-point (f s) f)))
(define (average-damp f)
  (lambda (x)
    (average x (f x))))
(define (square x) (* x x))

;FUNKCJA DO SPRAWDZENIA ILE TŁUMIEŃ NALEŻY UŻYĆ:
(define (test-root x n damps)
 (let ((root (lambda (y) (/ x (expt y (- n 1))))))
  (fixed-point 1.0 ((repeat average-damp damps) root))))

;TESTY ILOŚCI TŁUMIEŃ:
(test-root 81 4 2) ; - działa przy 2 tłumieniach, tak jak napisano w poleceniu
;(test-root 1024 10 1) - zapętla się, nie doczekałem się wyniku
(test-root 1024 10 2) ; - wynik nie jest dokładny
(test-root 1024 10 3) ; - działa
(test-root (expt 2.5 17) 17 3) ; - wynik nie jest dokładny
(test-root (expt 2.5 17) 17 4) ; - działa
;(test-root (expt 1.5 70) 70 4) - zapętla się
(test-root (expt 1.5 70) 70 6) ; - działa
;Z powyższych testów wnioskuje, że aby ZAWSZE otrzymać dobry wynik
;należy zastosować floor(logn) (logarytm o podstawie 2) tłumień.

;FUNKCJA OBLICZAJĄCA PIERWIASTEK N-TEGO STOPNIA
(define (nth-root n x)
  (define (good-damp)
    (repeat average-damp (floor (log n 2))))
  (let ((root (lambda (y) (/ x (expt y (- n 1))))))
  (fixed-point 1.0 ((good-damp) root))))

;TESTY FUNKCJI NTH-ROOT:
(nth-root 4 81)
(nth-root 15 (expt (- 1.2) 15))
(nth-root 20 (expt 2 20))
(nth-root 10 0)