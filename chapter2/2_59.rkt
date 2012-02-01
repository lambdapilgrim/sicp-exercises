#!/usr/bin/env racket
#lang racket

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        ((not (element-of-set? (car set1) set2)) (cons (car set1) (union-set (cdr set1) set2)))
        (else (union-set (cdr set1) set2))))
        

(define s (list 2 3 4 5))
(define t (list 1 2 4))

(union-set s t)

;Result:
;'(3 5 1 2 4)
