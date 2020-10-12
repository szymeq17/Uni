#lang racket
(require rackunit)
(require rackunit/text-ui)
 

(define (inc n)
  (+ n 1))

;;; tagged lists
(define (tagged-list? len-xs tag xs)
  (and (list? xs)
       (= len-xs (length xs))
       (eq? (first xs) tag)))

;;; ordered elements
(define (make-elem pri val)
  (cons pri val))

(define (elem-priority x)
  (car x))

(define (elem-val x)
  (cdr x))

;;; leftist heaps (after Okasaki)

;; data representation

;(hnode element ranga lewe prawe) - reprezentacja kopca
(define leaf 'leaf)

(define (leaf? h) (eq? 'leaf h))

(define (hnode? h)
  (and (tagged-list? 5 'hnode h)
       (natural? (caddr h))))

(define (make-hnode elem heap-a heap-b)
  ;;; ranga lewego poddrzewa jest nie mniejsza niz ranga prawego
  ;;; czyli ranga lewego >= ranga prawego
  (if (>= (rank heap-a) (rank heap-b))
      (list 'hnode elem (inc (rank heap-b)) heap-a heap-b)
      (list 'hnode elem (inc (rank heap-a)) heap-b heap-a)))

(define (hnode-elem h)
  (second h))

(define (hnode-left h)
  (fourth h))

(define (hnode-right h)
  (fifth h))

(define (hnode-rank h)
  (third h))

(define (hord? p h)
  (or (leaf? h)
      (<= p (elem-priority (hnode-elem h)))))

(define (heap? h)
  (or (leaf? h)
      (and (hnode? h)
           (heap? (hnode-left h))
           (heap? (hnode-right h))
           (<= (rank (hnode-right h))
               (rank (hnode-left h)))
           (= (rank h) (inc (rank (hnode-right h))))
           (hord? (elem-priority (hnode-elem h))
                  (hnode-left h))
           (hord? (elem-priority (hnode-elem h))
                  (hnode-right h)))))

(define (rank h)
  (if (leaf? h)
      0
      (hnode-rank h)))


;; operations

(define empty-heap leaf)

(define (heap-empty? h)
  (leaf? h))

(define (heap-insert elt heap)
  (heap-merge heap (make-hnode elt leaf leaf)))

(define (heap-min heap)
  (hnode-elem heap))

(define (heap-pop  heap)
  (heap-merge (hnode-left  heap) (hnode-right  heap)))

(define (heap-merge h1 h2)
  (cond
   [(leaf? h1) h2]
   [(leaf? h2) h1]
   [(>= (elem-priority (heap-min h2)) (elem-priority (heap-min h1)))
       (make-hnode (heap-min h1)
                   (hnode-left h1)
                   (heap-merge (hnode-right h1) h2))]
   [else (heap-merge h2 h1)]))


;;; heapsort. sorts a list of numbers.
(define (heapsort xs) ; na poczatku przerabiamy liste na kopiec - bierzemy pierwszy element listy, wkładamy do kopca i powtarzamy rekurencyjnie dla (cdr lista)
  (define (list-to-heap xs heap)
    (if (null? xs)
        heap
        (list-to-heap (cdr xs) (heap-insert (make-elem (car xs) (car xs)) heap))))
  (define (find-and-remove-min heap) ; jako ze umiemy znajdowac minimalny element oraz go usuwac to mozemy pobierac aktualne min az oproznimy caly kopiec
    (if (heap-empty? heap)
        null
        (cons (elem-val (heap-min heap)) (find-and-remove-min (heap-pop heap)))))
    (find-and-remove-min (list-to-heap xs empty-heap)))


;;; check that a list is sorted (useful for longish lists)
(define (sorted? xs)
  (cond [(null? xs)              true]
        [(null? (cdr xs))        true]
        [(<= (car xs) (cadr xs)) (sorted? (cdr xs))]
        [else                    false]))






;testy
(define heap-sort-tests
  (test-suite "heap-sort-procedure-tests"
              (test-case "heap-sort-test-number-1"
                         (sorted? (heapsort (list))))
             
              (test-case "heap-sort-test-number-2"
                         (sorted? (heapsort (list 1 2 3 4 5 6 7 0))))
             
              (test-case "heap-sort-test-number-3"
                         (sorted? (heapsort (list 1 1 1 1 1 1))))
           
              (test-case "heap-sort-test-number-4"
                         (sorted? (heapsort (list 8 7 6 5 4 3 2 1 ))))
             
              (test-case "heap-sort-test-number-5"
                         (sorted? (heapsort (list 2 15 7 8 1 6 8 4))))
             
              (test-case "heap-sort-test-number-6"
                         (sorted? (heapsort (list 1 2 4 6 0 6 2 2414 5236 73456 121 2541))))
             
              (test-case "heap-sort-test-number-7"
                         (sorted? (heapsort (list 0 1 0 1 0 1 0 1 0 1 0 1 0 1)))) 
              ))
 
(run-tests heap-sort-tests)