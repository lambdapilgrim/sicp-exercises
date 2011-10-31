#! /usr/bin/env racket
#lang racket

(define (fringe tree)
  (cond
    ((null? tree) '())
    ((not (pair? tree)) (list tree))
    (else (append (fringe (car tree)) (fringe (cdr tree))))))

(fringe (list 1 2 (list 5 6 7) 4))
(fringe (list (list 1 2 3) (list 4 5 6)))

(define x (list (list 1 2) (list 3 4)))
(fringe x)
(fringe (list x x))

;'(1 2 5 6 7 4)
;'(1 2 3 4 5 6)
;'(1 2 3 4)
;'(1 2 3 4 1 2 3 4)

