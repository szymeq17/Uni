#lang racket
; WSPÓŁPRACA DAWID DUDEK NATALIA CZEREP SZYMON RYSZ

(provide philosopher)

(define (philosopher dining-table i)
  (if (< i (modulo (+ i 1) 5))
      (begin ((dining-table 'pick-fork) i)
             ((dining-table 'pick-fork) (+ i 1))
             ((dining-table 'put-fork) i)
             ((dining-table 'put-fork) (+ i 1)))
      (begin ((dining-table 'pick-fork) (modulo (+ i 1) 5))
             ((dining-table 'pick-fork) i)
             ((dining-table 'put-fork) (modulo (+ i 1) 5))
             ((dining-table 'put-fork) i))))

