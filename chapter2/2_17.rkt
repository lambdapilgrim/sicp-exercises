#! /usr/bin/env racket
#lang racket

(define (last-pair l)
  (if (null? (cdr l))
      l
      (last-pair (cdr l))))

(last-pair (list 1 2 3 4 5 6))
(last-pair (list 2 (list 10 20 30) 5 (list 2 1 3)))

;Result:
;'(6)
;'(2 1 3)
