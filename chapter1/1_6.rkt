#! /usr/bin/env racket
#lang racket

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (square x)
  (* x x))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (improve guess x)
  (average guess (/ x guess)))

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))

(define (sqrt x)
  (sqrt-iter 1.0 x))

(sqrt 9)

;Alyssa's version of 'if' has been implemented using general procedures and is
;not a special form.

;Using the applicative order substitution, all the arguments of the procedure
;new-if will be evaluated before applying the procedure. This will cause the
;recursive call to never terminate, because the third argument of new-if is a
;procedure call to itself, without termination condition.
