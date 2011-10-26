#! /usr/bin/env racket
#lang racket

(define (composee f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (if (= n 1)
      f
      (composee f (repeated f (- n 1)))))

(define square (lambda (x) (* x x)))

(define cube (lambda (x) (* x x x)))

((repeated square 2) 5)

;625

((repeated cube 3) 2)
;134217728
