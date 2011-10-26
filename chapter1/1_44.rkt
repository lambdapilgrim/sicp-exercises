#! /usr/bin/env racket
#lang racket

(define dx 0.0001)

(define square (lambda (x) (* x x)))

(define (composee f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (if (= n 1)
      f
      (composee f (repeated f (- n 1)))))

(define (smooth f)
  (lambda (x) (/ (+ (f x) (f (+ x dx)) (f (- x dx))) 3)))

(define (n-fold-smooth f n)
  (repeated (smooth f) n)) 

((smooth square) 5)
;25.000000006666667

((n-fold-smooth square 5) 5)
;2.328306446671646e+22
