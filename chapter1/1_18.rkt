#! /usr/bin/env racket
#lang racket

(define (fast-mult-iter a b p)
  (cond
    ((= 0 a) p)
    ((even? a) (fast-mult-iter (half a) (double b) p))
    (else (fast-mult-iter (- a 1) b (+ p b)))))

(define (half x)
  (/ x 2))

(define (double x)
  (+ x x))

(define (fast-mult a b)
  (fast-mult-iter a b 0))

(fast-mult 34 23)
;782
