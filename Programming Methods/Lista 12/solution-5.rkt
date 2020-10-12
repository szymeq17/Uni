#lang racket
;;Korzystałam z https://docs.racket-lang.org/guide/contracts-examples.html#%28part._.A_.Parameteric__.Simple__.Stack%29  (jako inspiracja jak takie struktury mogą być reprezentowane w rackecie)

(require "graph.rkt")
(provide bag-stack@ bag-fifo@)


;; struktura danych - stos
(define-unit bag-stack@
  (import)
  (export bag^)
  
  (define (bag? xs)
    (list? xs))
  
  (define empty-bag '())

  (define (bag-empty? xs)
    (null? xs))
  
  (define (bag-insert xs e)
    (if (bag-empty? xs)
        (list e)
        (cons e xs)))
  
  (define (bag-peek xs)
    (car xs))
  
  (define (bag-remove xs)
    (cdr xs))  

)

;; struktura danych - kolejka FIFO
(define-unit bag-fifo@
  (import)
  (export bag^)
    (define (bag? xs)
    (and (list? xs)
         (eq? (first xs) 'queue)
         (list? (second xs))
         (list? (third xs))
         (= (length xs) 3)))
  
  (define empty-bag (list 'queue '() '()))   ;; queue: in : out

  (define (bag-empty? xs)
    (and (null? (second xs))
         (null? (third xs))))
  
  (define (out-empty xs)
      (if (null? (third xs))
          (list 'queue '() (reverse (second xs)))
          xs))
  
  (define (insert-in x-in e)
      (if (null?  x-in)
          (list e)
          (cons e x-in)))
  
  (define (bag-insert xs e)
    (out-empty (list 'queue (insert-in (second xs) e) (third xs))))
    
  (define (bag-peek xs)
    (car (third xs)))

    (define (bag-remove xs)
      (out-empty (list 'queue (second xs) (cdr (third xs)))))
)

;; otwarcie komponentów stosu i kolejki

(define-values/invoke-unit bag-stack@
  (import)
  (export (prefix stack: bag^)))

(define-values/invoke-unit bag-fifo@
  (import)
  (export (prefix fifo: bag^)))

;; testy w Quickchecku
(require quickcheck)

;; testy kolejek i stosów
(define-unit bag-tests@
  (import bag^)
  (export)
  
  ;; test przykładowy: jeśli do pustej struktury dodamy element
  ;; i od razu go usuniemy, wynikowa struktura jest pusta
  (quickcheck
   (property ([s arbitrary-symbol])
             (bag-empty? (bag-remove (bag-insert empty-bag s)))))
  
  
  (quickcheck                          ;; jesli w strukturze mamy jeden element to peek zwróci dokładnie ten jedyny element (peek i insert nie zmieniają elementów struktury)
   (property ([s arbitrary-symbol])
             (eq? (bag-peek (bag-insert empty-bag s))  s)))
 
  
)

;; uruchomienie testów dla obu struktur danych

(invoke-unit bag-tests@ (import (prefix stack: bag^)))
(invoke-unit bag-tests@ (import (prefix fifo: bag^)))

(define-unit stack-tests@
  (import bag^)
  (export)
  
  (quickcheck                                        ;; dodajemy element na poczatek stosu
   (property ([s arbitrary-symbol]
              [x arbitrary-symbol])
             (eq? (car (bag-insert (bag-insert empty-bag s) x)) x)))
  (quickcheck                                        ;; usuwamy element z początku stosu
   (property ([s arbitrary-symbol]
              [x arbitrary-symbol])
             (eq? (car (bag-remove (bag-insert (bag-insert empty-bag s) x))) s)))

  (quickcheck                                        ;; bierzemy element z początku stosu
   (property ([s arbitrary-symbol]
              [x arbitrary-symbol])
             (eq? (bag-peek (bag-insert (bag-insert empty-bag s) x)) x)))
 
  
   (quickcheck                                        ;; bag-insert nie zmienia kolejnosci dodawanych elementow
   (property ([s arbitrary-symbol]
              [x arbitrary-symbol]
              [e arbitrary-symbol])
             (eq? (bag-insert (bag-insert (bag-insert empty-bag s) x) e) (list e x s))))
  )

(define-unit fifo-tests@
  (import bag^)
  (export)
  
  (quickcheck                                        ;; po dodaniu kilku elemetow częśc wyjściowa fifo zawiera tylko jeden element
   (property ([s arbitrary-symbol]
              [x arbitrary-symbol]
              [e arbitrary-symbol])
             (= (length (third (bag-insert (bag-insert (bag-insert empty-bag s) x) e))) 1)))
  
  (quickcheck                                        ;; po dodaniu kilku elemetow częśc wyjściowa fifo zawiera pierwszy dodadny element
   (property ([s arbitrary-symbol]
              [x arbitrary-symbol]
              [e arbitrary-symbol])
             (eq? (car (third (bag-insert (bag-insert (bag-insert empty-bag s) x) e))) s)))

  (quickcheck                                        ;; po dodaniu kilku elemetow częśc kazdy kolejny trafia na początek części wejsciowej
   (property ([s arbitrary-symbol]
              [x arbitrary-symbol]
              [e arbitrary-symbol])
             (eq? (car (second (bag-insert (bag-insert (bag-insert empty-bag s) x) e))) e)))

  (quickcheck                                        ;; bierzemy element który został dodany jako pierwszy
   (property ([s arbitrary-symbol]
              [x arbitrary-symbol])
             (eq? (bag-peek (bag-insert (bag-insert empty-bag s) x)) s)))
)
  
  

;; otwarcie komponentu grafu
(define-values/invoke-unit/infer simple-graph@)

;; otwarcie komponentów przeszukiwania 
;; w głąb i wszerz
(define-values/invoke-unit graph-search@
  (import graph^ (prefix stack: bag^))
  (export (prefix dfs: graph-search^)))

(define-values/invoke-unit graph-search@
  (import graph^ (prefix fifo: bag^))
  (export (prefix bfs: graph-search^)))

;; graf testowy
(define test-graph
  (graph
   (list 1 2 3 4)
   (list (edge 1 3)
         (edge 1 2)
         (edge 2 4))))

(define test1-graph
  (graph
   (list 1 2 3 4)
   (list (edge 1 4)
         (edge 1 2)
         (edge 2 4))))
(define test2-graph
  (graph
   (list 1)
   '()))
(define test3-graph
  (graph
   (list 1 3 4)
   (list (edge 1 3)
         (edge 4 3)
         (edge 3 4))))
(define test4-graph
  (graph
   (list 1 2 3 4)
   (list (edge 1 2)
         (edge 2 3)
         (edge 3 4))))
;; uruchomienie przeszukiwania na przykładowym grafie
(bfs:search test-graph 1)
(dfs:search test-graph 1)
(bfs:search test1-graph 4)
(dfs:search test1-graph 4)
(bfs:search test2-graph 1)
(dfs:search test2-graph 1)
(bfs:search test3-graph 3)
(dfs:search test3-graph 3)
(bfs:search test4-graph 4)
(dfs:search test4-graph 4)
