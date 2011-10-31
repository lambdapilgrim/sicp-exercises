#! /usr/bin/env racket
#lang racket

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

(define (make-point x y)
  (cons x y))

(define (start-segment s)
  (car s))

(define (end-segment s)
  (cdr s))

(define (make-segment sp ep)
  (cons sp ep))

(define (mid-point s)
  (make-point (/ (+ (x-point (start-segment s)) (x-point (end-segment s))) 2) (/ (+ (y-point (start-segment s)) (y-point (end-segment s))) 2)))

(define p1 (make-point 2 3))
(define p2 (make-point 1 2))
(define p3 (make-point -21 2))
(define p4 (make-point -5 16))
(define s1 (make-segment p1 p2))
(define s2 (make-segment p3 p4))

(print-point (mid-point s1))
(print-point (mid-point s2))

;(3/2,5/2)
;(-13,9)
