#! /usr/bin/env racket
#lang racket

(define (sum term a next b)
  (define (iter a result)
    (if (< b a)
        result
        (iter (next a) (+ (term a) result))))
  (iter a 0))

(define (square x)
  (* x x))

(define (inc x)
  (+ 1 x))

(sum square 1 inc 5)
;55
