#!/usr/bin/env racket
#lang racket

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (cons x set))

(define (union-set set1 set2)
  (append set1 set2))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

(element-of-set? 6 '(3 4 2 4 5 6))
(adjoin-set 9 '(9 8 4 2))
(union-set '(3 5 4) '(3 4 2 4 5 3 2 6))
(intersection-set '(3 4 5 3 6) '(3))
;#t
;'(9 9 8 4 2)
;'(3 5 4 3 4 2 4 5 3 2 6)
;'(3 3)

;adjoin-set and union-set become constant time operations instead of linear time.
;However, element-of-set? and intersection-set still remain linear time operations.
;Instances where there are a more number of operations related to creating sets by
;adding an element or taking union of two sets, the representation with duplicate 
;values will be desirable. Instances where there are more number of set operations
;like element-of-set or intersection-set, the alternative representation will be
;more useful.
