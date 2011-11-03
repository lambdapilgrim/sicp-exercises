#! /usr/bin/env racket
#lang racket

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))


(define (count-leaves t)
  (accumulate (lambda (x y) (+ (if (not (pair? x)) 1 (count-leaves x)) y)) 0 (map (lambda (x) x) t)))


(count-leaves (list 1 2 6 (list 3 2 4) 8 9))

;Not sure why map is needed, will come to it later.

;8
