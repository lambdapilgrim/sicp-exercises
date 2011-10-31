#! /usr/bin/env racket
#lang racket

(define square (lambda(x) (* x x)))

(define (tree-map proc tree)
  (cond
    ((null? tree) '())
    ((not (pair? tree)) (proc tree))
    (else (cons (tree-map proc (car tree)) (tree-map proc (cdr tree))))))

(define (square-tree-with-map tree)
  (tree-map square tree))

(square-tree-with-map (list 43 354 2 3 4))
(square-tree-with-map (list 5 2 (list 3 4 5) 342 95))
  
  
  
;Result:
;'(1849 125316 4 9 16)
;'(25 4 (9 16 25) 116964 9025)

