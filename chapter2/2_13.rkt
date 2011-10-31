#! /usr/bin/env racket
#lang racket

(define (make-interval a b) (cons a b))
(define (lower-bound c) (car c))
(define (upper-bound c) (cdr c))

(define (pos? n)
  (> n 0))

(define (make-center-percent c p)
  (define (make-lower-bound c p)
    (- c (* c (/ p 100))))
  (define (make-upper-bound c p)
    (+ c (* c (/ p 100))))
  (make-interval (make-lower-bound c p)
                 (make-upper-bound c p)))

(define (center x)
  (/ (+ (upper-bound x) (lower-bound x)) 2))

(define (percent x)
  (let
      ((center (/ (+ (upper-bound x) (lower-bound x)) 2))
       (lb (lower-bound x))
       (ub (upper-bound x)))
    (* (/ (- ub center) center) 100)))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

;;Experimenting with various intervals (positive) made using
;make-center-percent, multiplying them, and noting the percent of the resulting
;interval

(define a (make-center-percent 432.0 8.0))
(define b (make-center-percent 10.0 4.0))
(define c (make-center-percent 56.0 19.0))

(percent (mul-interval a b))
(percent (mul-interval b c))
(percent (mul-interval c a))

;11.961722488038268
;22.826518459706246
;26.595744680851062

;It is clear that percent value of the product interval is approximately sum of
;percent values of factor intervals

;Experimenting with the negative intervals:

(define d (make-center-percent 87.0 21.0))
(define e (make-center-percent -401.0 4.0))
(define f (make-center-percent -5.0 13.0))

(percent (mul-interval d e))
(percent (mul-interval e f))
(percent (mul-interval f d))

;-24.79174930583101
;16.912057302029464
;-33.096466465492064

;It is evident that the absolute value of the percent of product is
;approximately the same as sum of percent of factors, however, the signs get
;multiplied; Negative percent values are same as positive values if we are
;talking about intervals (lower bound and upper bound get interchanged?)
