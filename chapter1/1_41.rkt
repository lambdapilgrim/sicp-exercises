#! /usr/bin/env racket
#lang racket

(define (double f)
  (lambda (x) (f (f x))))

(define (inc x)
  (+ x 1))

(((double (double double)) inc) 5)

;21

;Explanation: The resulting procedure of ((double (double double)) inc) applies inc 16 times to the passed value.
