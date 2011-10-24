#! /usr/bin/env racket
#lang racket

(define (cont-frac-rec n d k)
  (define (cont-frac-rec-aux n d k i)
  (if (= i k)
      (/ (n k) (d k))
      (/ (n i) (+ (d i) (cont-frac-rec-aux n d k (+ 1 i))))))
  (cont-frac-rec-aux n d k 1))


(define (tan-cf x k)
  (cont-frac-rec (lambda (i) (if (= i 1) x (* -1.0 (* x x)))) (lambda (i) (+ 1.0 (* 2 (- i 1)))) k))

(tan-cf (/ 3.1412 4) 50)


;0.9998036924746865
