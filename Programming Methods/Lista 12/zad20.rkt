#lang racket

;WSPÓŁPRACA SZYMON RYSZ, DAWID DUDEK
(require "graph.rkt")
(provide bag-stack@ bag-fifo@)

;; struktura danych - stos
(define-unit bag-stack@
  (import)
  (export bag^)
  (define (bag? b)
    (and (list? b)
         (= (length b) 2)
         (eq? (car b) 'stack)))
  (define (stack-list b) (cadr b))
  (define (stack-cons l) (list 'stack l))
  (define empty-bag (stack-cons '()))
  (define (bag-empty? b) (eq? (stack-list b) '())) 
  (define (bag-insert b v) (stack-cons (cons v (stack-list b))))
  (define (bag-peek b) (car (stack-list b)))
  (define (bag-remove b) (stack-cons (cdr (stack-list b))))
)

;; struktura danych - kolejka FIFO
(define-unit bag-fifo@
  (import)
  (export bag^)
  (define (bag? b)
    (and (list? b)
         (= (length b) 3)
         (eq? (car b) 'fifo)))
  (define (in-list b) (second b))
  (define (out-list b) (third b))
  (define (fifo-cons in out) (list 'fifo in out))
  (define empty-bag (fifo-cons '() '()))
  (define (bag-empty? b) (and (null? (in-list b))
                              (null? (out-list b))))
  (define (fifo-update b)
    (if (null? (out-list b))
        (fifo-cons '() (reverse (in-list b)))
        (fifo-cons (in-list b) (out-list b))))
  (define (bag-insert b v)
    (fifo-update (fifo-cons (cons v (in-list b))
                            (out-list b))))
  (define (bag-peek b) (car (out-list b)))
  (define (bag-remove b)
    (fifo-update (fifo-cons (in-list b)
                            (cdr (out-list b)))))   
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
  
  (quickcheck
   (property ([s arbitrary-symbol])
             (bag-empty? (bag-remove (bag-insert empty-bag s)))))

  
  (quickcheck
   (property ([x arbitrary-symbol])
             (eq? x (bag-peek (bag-insert empty-bag x)))))

  (quickcheck
   (property () (bag-empty? empty-bag)))

  
)

;; uruchomienie testów dla obu struktur danych

(invoke-unit bag-tests@ (import (prefix stack: bag^)))
(invoke-unit bag-tests@ (import (prefix fifo: bag^)))


;TESTY STACK

(define-unit stack-tests@
  (import bag^)
  (export)
  
  (define arbitrary-stack-list
  (arbitrary-list arbitrary-symbol))

  (define (list->stack l) (list 'stack l))

  
  (quickcheck
   (property ([s arbitrary-symbol]
             [stack arbitrary-stack-list])
             (eq? s (bag-peek (bag-insert (list->stack stack) s)))))
  
  (quickcheck
   (property ([s arbitrary-symbol]
             [stack arbitrary-stack-list])
             (==> (not (empty? stack))
                  (let* ([true-stack (list->stack stack)]
                    [current-peek (bag-peek true-stack)]
                    [new-stack (bag-insert true-stack s)])
                    (eq? current-peek (bag-peek (bag-remove new-stack)))))))

)

(invoke-unit stack-tests@ (import (prefix stack: bag^)))


;TESTY FIFO
(define-unit fifo-tests@
  (import bag^)
  (export)
  
  (define arbitrary-fifo-list
  (arbitrary-list arbitrary-symbol))
  
  (define (list->fifo l) 
      (list 'fifo '() l))

 (quickcheck
   (property ([s arbitrary-symbol]
             [fifo arbitrary-fifo-list])
             (==> (not (empty? fifo))
                  (eq? (bag-peek (list->fifo fifo))
                  (bag-peek (bag-insert (list->fifo fifo) s))))))

  (quickcheck
   (property ([s arbitrary-symbol]
             [fifo arbitrary-fifo-list])
             (==> (not (empty? fifo))
                 (==> (not (eq? (bag-peek (list->fifo fifo)) s))
                  (not (eq? s (bag-peek (bag-insert (list->fifo fifo) s))))))))
             
          

)

(invoke-unit fifo-tests@ (import (prefix fifo: bag^)))

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

(define test-graph2
  (graph
   (list 1 2 3 4 5)
   (list (edge 1 2)
         (edge 2 3)
         (edge 3 4)
         (edge 4 5)
         (edge 1 3)
         (edge 3 2))))

(define test-graph3
   (graph
     (list 'a 'b 'c 'd)
     (list (edge 'a 'b)
           (edge 'b 'c)
           (edge 'b 'd)
           (edge 'a 'c)
           (edge 'a 'd))))


;; uruchomienie przeszukiwania na przykładowym grafie
(bfs:search test-graph 1)
(dfs:search test-graph 1)

(bfs:search test-graph2 1)
(dfs:search test-graph2 1)

(bfs:search test-graph3 'a)
(dfs:search test-graph3 'a)
