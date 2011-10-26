#! /usr/bin/env racket
#lang racket

(define (iterative-improve good-enough? improve)
  (lambda (guess)
    (if (good-enough? guess)
        guess
        ((iterative-improve good-enough? improve) (improve guess)))))

(define (sqrti x)
  ((iterative-improve
   (lambda(y) (< (abs (- (* y y) x)) 0.00001))
   (lambda(y) (/ (+ y (/ x y)) 2))) 1.0))

(define (fixed-point f first-guess)
  ((iterative-improve
    (lambda (y) (if (< (abs (- y (f y))) 0.0001) #t #f))
    f) first-guess))

(sqrti 9)
(fixed-point (lambda (y) (cos y)) 1.0)

;3.000000001396984
;0.7391301765296711
