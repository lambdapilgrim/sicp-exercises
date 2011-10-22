#! /usr/bin/env racket
#lang racket

(define (fast-expt-iter b n a)
  (cond ((= n 0) a)
        ((even? n) (fast-expt-iter (square b) (/ n 2) a))
        (else (fast-expt-iter b (- n 1) (* b a)))))

(define (square x)
  (* x x))

(define (fast-expt b n)
  (fast-expt-iter b n 1))

(fast-expt 3 5)
;243
(fast-expt 5 23)
;11920928955078125
