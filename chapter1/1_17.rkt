#! /usr/bin/env racket
#lang racket

(define (fast-mult a b)
  (cond
    ((= 0 a) 0)
    ((even? a) (double (fast-mult (half a) b)))
    (else (+ b (fast-mult (- a 1) b)))))

(define (half x)
  (/ x 2))

(define (double x)
  (+ x x))

(fast-mult 60 583)
;34980
