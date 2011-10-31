#! /usr/bin/env racket
#lang racket

(define (square x)
  (* x x))

(define (expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (expt b (/ n 2))))
        (else (* b (expt b (- n 1))))))

(define (cons x y)
  (* (expt 2 x) (expt 3 y)))

(define (car z)
  (num2s z 0))

(define (cdr z)
  (num3s z 0))

(define (num2s z i)
  (if (not (= 0 (remainder z 2))) i
      (num2s (/ z 2) (+ i 1))))

(define (num3s z i)
  (if (not (= 0 (remainder z 3))) i
      (num3s (/ z 3) (+ i 1))))

(car(cons 6 3))
(cdr(cons 5 2))

;6
;2


