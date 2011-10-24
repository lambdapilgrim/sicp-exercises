#! /usr/bin/env racket
#lang racket

(define (accumulate-rec combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a) (accumulate-rec combiner null-value term (next a) next b))))

(define (accumulate-iter combiner null-value term a next b)
  (define (iter a result)
  (if (> a b)
      result
      (iter (next a) (combiner (term a) result))))
  (iter a null-value))

(define (product-rec term a next b)
  (define (multiply x y) (* x y))
  (accumulate-rec multiply 1 term a next b))

(define (sum-rec term a next b)
  (define (add x y) (+ x y))
  (accumulate-rec add 0 term a next b))

(define (product-iter term a next b)
  (define (multiply x y) (* x y))
  (accumulate-iter multiply 1 term a next b))

(define (sum-iter term a next b)
  (define (add x y) (+ x y))
  (accumulate-iter add 0 term a next b))

(define (factorial n)
  (product-iter iden 1 inc n))

(define (pi a b)
  (define (pi-term x)
    (/ (* x (+ x 2.0)) (square (+ x 1))))
  (define (pi-next x)
    (+ x 2))
  (* 4 (product-iter pi-term a pi-next b)))

(define (sum-cubes a b)
  (sum-iter cube a inc b))

(define (pi-sum a b)
  (define (pi-term x)
    (/ 1.0 (* x (+ x 2))))
  (define (pi-next x)
    (+ x 4))
  (sum-iter pi-term a pi-next b))

(define (iden x)
  x)
(define (inc x)
  (+ x 1))
(define (square x)
  (* x x))
(define (cube x)
  (* x x x))

  
(pi 2 100)
;3.1570301764551667

(factorial 8)
;40320

(sum-cubes 1 10)
;3025

(* 8 (pi-sum 1 1000))
;3.139592655589782
