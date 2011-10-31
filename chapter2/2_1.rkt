#! /usr/bin/env racket
#lang racket

(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))

(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))

(define (equal-rat? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

(define (make-rat n d)
  (let ((g (gcd (abs n) (abs d))) (pos? (or (and (> n 0) (> d 0)) (and (< n 0) (< d 0)))))
    (if pos? (cons (/ (abs n) g) (/ (abs d) g)) (cons (* -1 (/ (abs n) g)) (/ (abs d) g)))))

(define (numer x)
  (car x))

(define (denom x)
  (cdr x))

(define one-third (make-rat 1 3))
(define minus-one-third (make-rat -1 3))
(define one-half (make-rat 1 2))
(define one-fourth (make-rat 1 4))
(define a (make-rat -1 -6))
(define b (make-rat 5 -8))


(print-rat (add-rat one-third one-fourth))

(print-rat (sub-rat b a))
(print-rat (sub-rat a b))
(print-rat (mul-rat b a))
(print-rat (div-rat a b))
(print-rat (add-rat b a))


;7/12
;-19/24
;19/24
;-5/48
;-4/15
;-11/24
