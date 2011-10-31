#! /usr/bin/env racket
#lang racket

(define (for-each proc l)
  (if (null? l)
      (exit)
      ((proc (car l)) (for-each proc (cdr l)))))

(for-each (lambda(x) (newline)(display x)) '(4 3 542 2 23))

;4
;3
;542
;2
;23
