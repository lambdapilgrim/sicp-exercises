#! /usr/bin/env racket
#lang racket

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (square x)
  (* x x))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (good-enough-alt? prevguess guess x)
  (< (/ (abs(- prevguess guess)) guess) 0.001))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (sqrt-iter-alt prevguess guess x)
  (if (good-enough-alt? prevguess guess x)
      guess
      (sqrt-iter-alt guess (improve guess x) x)))

(define (sqrt x)
  (sqrt-iter 1.0 x))

(define (sqrt-alt x)
  (sqrt-iter-alt 0.9 1.0 x))

(sqrt 1e-32)
;0.03125
(sqrt 8e45)
;Infinite procedure calls
(sqrt-alt 1e-32)
;1.0000000000006072e-016
(sqrt-alt 8e45)
;8.944271910031709e+022

;I included display calls in good-enough? procedure to see what happens to the
;values of guess at each sqrt-iter call.

;For very small numbers, once the value of guess drops to 0.03125 (in this case)
;good-enough? returns true. This is because square of 0.03125 is 0.0009765625,
;which when subtracted from the extremely small number becomes less than 0.001

;For very large numbers, guess and square of guess are limited by the precision
;provided by the interpreter for floating point numbers. In my case, for the
;number 1e34, the procedure ran fine, but not for 1e35. The interpreter cannot
;hold an operation like (- (square <largenumber>) <anotherlargenumber>) with
;limited number of bits to represent base and exponent values. So, good-enough?
;returns false, even though actually it should return true, and the process
;never terminates.

;The procedure good-enough-alt? avoids the situation with both small and large
;numbers. Previous guess and the current guess are going to be in the same
;range of each other, so the difference between previous guess and guess are
;going to get closer and closer to 0.
