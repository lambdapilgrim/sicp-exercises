#! /usr/bin/env racket
#lang racket

;Fixed point of the transformation:
;x -> 1 + 1/x

;x = 1 + 1/x

;or x2 - x - 1 = 0

;or x = (1 + sqrt(5))/2 = golden ratio


(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define goldenratio (fixed-point (lambda (x) (+ 1.0 (/ 1 x))) 1))

goldenratio

;1.6180327...
