#! /usr/local/bin/racket
#lang racket

(define (sum-of-squares-of-largest-two x y z)
  (cond
    ((and (>= x y) (>= x z)) (+ (* x x) (if (>= y z) (* y y)(* z z))))
    ((and (>= y z) (>= y x)) (+ (* y y) (if (>= z x) (* z z)(* x x))))
    ((and (>= z x) (>= z y)) (+ (* z z) (if (>= x y) (* x x)(* y y))))))

(sum-of-squares-of-largest-two 9 -3 -1)

;Result:
;82