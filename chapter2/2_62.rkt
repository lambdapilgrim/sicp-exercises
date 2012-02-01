#!/usr/bin/env racket
#lang racket

(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        ((= (car set1) (car set2)) (cons (car set1) (union-set (cdr set1) (cdr set2))))
        ((> (car set1) (car set2)) (cons (car set2) (union-set set1 (cdr set2))))
        (else (cons (car set1) (union-set (cdr set1) set2)))))

(union-set '(2 4 6 8) '(1 3 5 7))
(union-set '(1 2 3 4) '(5 6 7 8))
(union-set '(1 2 3 4 5 6 7 8) '(2 3 4))

;'(1 2 3 4 5 6 7 8)
;'(1 2 3 4 5 6 7 8)
;'(1 2 3 4 5 6 7 8)
;This takes steps equal to the sum of sizes of both sets
