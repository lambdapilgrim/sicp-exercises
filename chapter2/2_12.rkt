#! /usr/bin/env racket
#lang racket

(define (make-interval a b) (cons a b))
(define (lower-bound c) (car c))
(define (upper-bound c) (cdr c))

(define (make-center-percent c p)
  (make-interval (- c (* c (/ p 100)))
                 (+ c (* c (/ p 100)))))

(define (center x)
  (/ (+ (upper-bound x) (lower-bound x)) 2))

(define (percent x)
  (let
      ((center (/ (+ (upper-bound x) (lower-bound x)) 2))
       (lb (lower-bound x))
       (ub (upper-bound x)))
    (* (/ (- ub center) center) 100)))

(center(make-center-percent 5 20))
(percent (make-center-percent 5 20))

;5
;20
