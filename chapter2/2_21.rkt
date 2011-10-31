#! /usr/bin/env racket
#lang racket

(define (map proc items)
  (if (null? items)
      '()
      (cons (proc (car items))
            (map proc (cdr items)))))

(define (square-list items)
  (define square (lambda (x) (* x x)))
  (if (null? items)
      '()
      (cons (square (car items)) (square-list (cdr items)))))

(define (square-list-alt items)
  (map (lambda(x) (* x x)) items))


(square-list (list 4 5 3 24 5 9))
(square-list-alt (list 4 5 3 24 5 9))

;'(16 25 9 576 25 81)
;'(16 25 9 576 25 81)
