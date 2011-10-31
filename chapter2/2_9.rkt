#! /usr/bin/env racket
#lang racket

(define (make-interval a b) (cons a b))
(define (lower-bound c) (car c))
(define (upper-bound c) (cdr c))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (mul-interval x 
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))

(define (width z)
  (/ (- (upper-bound z) (lower-bound z)) 2))

(define x (make-interval 5.5 5.6))

(define y (make-interval 4.4 4.6))

(= (width (add-interval x y)) (+ (width x) (width y)))
(= (width (sub-interval x y)) (+ (width x) (width y)))

;#t
;#t
;Clearly, the width of sum of two intervals and the width of difference of two intervals are basically the function of widths of the intervals involved.
;Here, the function is sum i.e. width-of-sum and width-of-diff are both same as sum-of-widths

; Width of div and mul:

(width (div-interval x y))
(width (mul-interval x y))
(* (width x) (width y))
(/ (width x) (width y))
(+ (width x) (width y))
(- (width x) (width y))

;Result:
;0.03853754940711451
;0.7799999999999976
;0.0049999999999999645
;0.5
;0.14999999999999947
;-0.04999999999999982

;From above example, it's clear that width of division and multiplication of two intervals cannot be expressed as a function of their individual widths.

