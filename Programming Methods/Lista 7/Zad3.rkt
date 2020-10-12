#lang racket

(struct var (val)  #:transparent)
(struct conj (l r) #:transparent)
(struct disj (l r) #:transparent)
(struct neg (val)    #:transparent)

(struct all (val form)    #:transparent)
(struct exists (val form) #:transparent)

(define (prop? f)
  (or (boolean? f)
      (and (var? f)
           (symbol? (var-val f)))
      (and (conj? f)
           (prop? (conj-l f))
           (prop? (conj-r f)))
      (and (disj? f)
           (prop? (disj-l f))
           (prop? (disj-r f)))
      (and (neg? f)
           (prop? (neg-val f)))
      (and (all? f)
           (symbol? (all-val f))
           (prop? (all-form f)))
      (and (exists? f)
           (symbol? (exists-val f))
           (prop? (exists-form f)))))

;(prop? (all 'x (exists 'y (conj (var 'x) (var 'y)))))

(define (parse q)
  (cond
    [(boolean? q) q]
    [(symbol? q) (var q)]
    [(and (list? q) (= (length q) 2) (eq? (first q) 'neg))
     (neg (parse (second q)))]
    [(and (list? q) (= (length q) 3) (eq? (first q) 'disj))
     (disj (parse (second q)) (parse (third q)))]
    [(and (list? q) (= (length q) 3) (eq? (first q) 'conj))
     (conj (parse (second q)) (parse (third q)))]
    [(and (list? q) (= (length q) 3) (eq? (first q) 'all))
     (all (parse (second q)) (parse (third q)))]
    [(and (list? q) (= (length q) 3) (eq? (first q) 'exists))
     (exists (parse (second q)) (parse (third q)))]))

(parse '(exists x (disj (neg q) x)))