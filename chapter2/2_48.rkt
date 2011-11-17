#! /usr/bin/env racket
#lang racket

(define (make-vect xcor ycor)
  (cons xcor ycor))

(define (make-segment start end)
  (cons start end))

(define (start-segment seg)
  (car seg))

(define (end-segment seg)
  (cdr seg))

(start-segment (make-segment (make-vect 0 4) (make-vect 4 6)))

;Result:
;'(0 . 4)
