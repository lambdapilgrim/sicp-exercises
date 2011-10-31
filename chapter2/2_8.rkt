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

(define x (make-interval 5.5 5.6))
(define y (make-interval 6.7 6.6))

(add-interval x y)
(sub-interval x y)
(mul-interval x y)
(div-interval x y)

;'(-1.2000000000000002 . -1.0)
;'(12.1 . 12.3)
;'(-37.519999999999996 . -36.3)
;'(-0.8484848484848485 . -0.8208955223880596)

;sub-interval should be designed to have a min value considering that the first interval has its min value and the second its max, and a max value when first interval is at max and second at its min.
