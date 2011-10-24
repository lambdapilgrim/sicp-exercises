#! /usr/bin/env racket
#lang racket

(define (cont-frac-rec n d k)
  (define (cont-frac-rec-aux n d k i)
  (if (= i k)
      (/ (n k) (d k))
      (/ (n i) (+ (d i) (cont-frac-rec-aux n d k (+ 1 i))))))
  (cont-frac-rec-aux n d k 1))


(+ 2 (cont-frac-rec (lambda(i) 1.0) (lambda (i) (if (= (remainder (+ i 1) 3) 0.0) (* 2.0 (/ (+ 1 i) 3)) 1)) 20))

;2.718281828459045
