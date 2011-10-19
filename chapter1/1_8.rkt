#! /usr/bin/env racket
#lang racket

(define (cbrt-iter prevguess guess x)
  (if (good-enough? prevguess guess x)
      guess     
      (cbrt-iter guess (improve guess x)
                 x)))

(define (improve guess x)
  (/ (+ (/ x (square guess)) (* 2 guess)) 3))

(define (square x)
  (* x x))

(define (good-enough? prevguess guess x)
  (< (/ (abs(- prevguess guess)) guess) 1e-20))

(define (cbrt x)
  (cbrt-iter 0.9 1.0 x))

(cbrt 27)
;3.0
