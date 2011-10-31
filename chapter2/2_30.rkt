#! /usr/bin/env racket
#lang racket

(define (square-tree tree)
  (cond
    ((null? tree) '())
    ((number? tree) (* tree tree))
    (else (cons (square-tree (car tree)) (square-tree (cdr tree))))))

(square-tree (list 1 2 3 4 5))
(square-tree (list 8 42 (list 0 -7 12) 049))

(define (map proc items)
  (if (null? items)
      '()
      (cons (proc (car items))
            (map proc (cdr items)))))

(define (square-tree-with-map tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (square-tree-with-map sub-tree)
             (* sub-tree sub-tree))) tree))

(square-tree-with-map (list 43 354 2 3 4))
(square-tree-with-map (list 5 2 (list 3 4 5) 342 95))
  
  
  
;Result:
;'(1 4 9 16 25)
;'(64 1764 (0 49 144) 2401)
;'(1849 125316 4 9 16)
;'(25 4 (9 16 25) 116964 9025)
