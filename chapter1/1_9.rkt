#! /usr/bin/env racket
#lang racket

(+ 4 5)

;With 1st procedure:
(define (+ a b)
  (if (= a 0)
      b
      (inc (+ (dec a) b))))

;Using substitution model:
;(+ 4 5)
;(inc (+ 3 5))
;(inc (inc (+ 2 5)))
;(inc (inc (inc (+ 1 5))))
;(inc (inc (inc (inc (+ 0 5)))))
;(inc (inc (inc (inc 5))))
;(inc (inc (inc 6)))
;(inc (inc 7))
;(inc 8)
;9

;With 2nd procedure:
(define (+ a b)
  (if (= a 0)
      b
      (+ (dec a) (inc b))))

;Using substitution model:
;(+ 4 5)
;(+ (dec 4) (inc 5))
;(+ (dec 3) (inc 6))
;(+ (dec 2) (inc 7))
;(+ (dec 1) (inc 8))
;(+ 0 9)
;9

;From the above visualization, it is clear that process 2 is linearly iterative whereas process 1 is linearly recursive.
