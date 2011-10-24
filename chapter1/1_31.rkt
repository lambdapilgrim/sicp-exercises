#! /usr/bin/env racket
#lang racket

(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b) result
        (iter (next a) (* (term a) result))))
  (iter a 1))

(define (factorial n)
  (product-iter iden 1 inc n))

(define (pi a b)
  (define (pi-term x)
    (/ (* x (+ x 2.0)) (square (+ x 1))))
  (define (pi-next x)
    (+ x 2))
  (* 4 (product pi-term a pi-next b)))

(define (iden x)
  x)
(define (inc x)
  (+ x 1))
(define (square x)
  (* x x))

  
(pi 2 100)
;3.157030176455167

(factorial 5)
;120
