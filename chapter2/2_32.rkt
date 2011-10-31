#! /usr/bin/env racket
#lang racket

(define (map proc items)
  (if (null? items)
      '()
      (cons (proc (car items))
            (map proc (cdr items)))))

(define (subsets s)
  (if (null? s)
      (list '())
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (x) (cons (car s) x)) rest)))))

(subsets (list 1 2 3 4))

;'(() (4) (3) (3 4) (2) (2 4) (2 3) (2 3 4) (1) (1 4) (1 3) (1 3 4) (1 2) (1 2 4) (1 2 3) (1 2 3 4))

;Explanation:
;If the set is empty, the set of subsets is a set of an empty set
;Otherwise, it is the union of
;           1. set of subsets of the rest of the set
;           AND
;           2. the first element of the set added to each element of the set of the subsets of the rest of the set
