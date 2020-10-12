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
(define leaf 'leaf)

(define (leaf? h) (eq? 'leaf h))

(define (hnode? h)
  (and (tagged-list? 5 'hnode h)
       (natural? (caddr h))))

(define (make-hnode elem heap-a heap-b)
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

(define (heap-pop heap)
  (heap-merge (hnode-left heap) (hnode-right heap)))

(define (heap-merge h1 h2)
  (cond
   [(leaf? h1) h2]
   [(leaf? h2) h1]
   [(>= (elem-priority (heap-min h2)) (elem-priority (heap-min h1)))
       (make-hnode (heap-min h1)
                   (hnode-left h1)
                   (heap-merge (hnode-right h1) h2))]
   [else (heap-merge h2 h1)]))

;;; check that a list is sorted (useful for longish lists)
(define (sorted? xs)
  (cond [(null? xs)              true]
        [(null? (cdr xs))        true]
        [(<= (car xs) (cadr xs)) (sorted? (cdr xs))]
        [else                    false]))

;HEAP SORT:
(define (heap-sort xs)
  (define (list-to-heap xs h)
    (if (null? xs)
         h
        (list-to-heap (cdr xs) (heap-insert (make-elem (car xs) (car xs)) h))))
  (define (heap-to-list h)
    ;wyciąga najmniejszy element z kopca i wkłada do listy, a później usuwa go z kopca
    ;dopóki kopiec nie jest pusty
    (if (heap-empty? h)
        null
        (cons (elem-priority (heap-min h)) (heap-to-list (heap-pop h)))))
  (heap-to-list (list-to-heap xs empty-heap)))

;TESTY:
(define heap-sort-tests
  (test-suite "heap-sort-procedure-tests"
              (test-case "heap-sort-test-number-1"
                         (sorted? (heap-sort (list))))
             
              (test-case "heap-sort-test-number-2"
                         (sorted? (heap-sort (list 1 2 3 4 5 6 7))))
             
              (test-case "heap-sort-test-number-3"
                         (sorted? (heap-sort (list 0 0 0 0 0 0 0))))
           
              (test-case "heap-sort-test-number-4"
                         (sorted? (heap-sort (list 1 -1 1 -1 1 -1 ))))
             
              (test-case "heap-sort-test-number-5"
                         (sorted? (heap-sort (list 6 5 4 3 2 1))))
             
              (test-case "heap-sort-test-number-6"
                         (sorted? (heap-sort (list 1 23 8 -49 29 12 1))))
             
              (test-case "heap-sort-test-number-7"
                         (sorted? (heap-sort (list 2 1 3 2 1 3 2 1 3)))) 
              ))
 
(run-tests heap-sort-tests)
        










        