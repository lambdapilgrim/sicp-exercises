#!/usr/bin/env racket
#lang racket

;; 1 / the golden ratio = 0.618033989

;;Part a

(define (cont-frac-rec n d k)
  (define (cont-frac-rec-aux n d k i)
  (if (= i k)
      (/ (n k) (d k))
      (/ (n i) (+ (d i) (cont-frac-rec-aux n d k (+ 1 i))))))
  (cont-frac-rec-aux n d k 1))

(cont-frac-rec (lambda (i) 1.0) (lambda (i) 1.0) 11)

;0.6180555555555556

;;Part b

(define (cont-frac-iter n d k)
  (define (cont-frac-iter-aux n d k i result)
  (if (= i k)
      result
      (cont-frac-iter-aux n d k (+ 1 i) (/ (n i) (+ result (d i))))))
  (cont-frac-iter-aux n d k 1 (/ (n 1)(d 1))))

(cont-frac-iter (lambda (i) 1.0) (lambda (i) 1.0) 11)

;0.6180555555555556

;By successively increasing the value of k, the minimum value of k that gives the value of 1/theta accurate to 4 decimal places is 11
