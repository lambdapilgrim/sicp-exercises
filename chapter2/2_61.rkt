#!/usr/bin/env racket
#lang racket

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((> (car set) x) (cons x set))
        (else (cons (car set) (adjoin-set x (cdr set))))))

(adjoin-set 4 '(1 2 5 6 8))

(adjoin-set 0 '(1 2 5 6 8))

(adjoin-set 9 '(1 2 5 6 8))

;'(1 2 4 5 6 8)
;'(0 1 2 5 6 8)
;'(1 2 5 6 8 9)

;By comparing the element x with first element of the set, it is guaranteed that we
;are not traversing through the ordered list beyond the position at which x will be
;inserted. On average this will take n/2 steps.


