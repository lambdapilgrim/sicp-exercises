#! /usr/bin/env racket
#lang racket

;Recursive process

(define (f n)
  (cond
    ((= n 0) 0)
    ((= n 1) 1)
    ((= n 2) 2)
    (else (+ (f (- n 1)) (* 2 (f (- n 2))) (* 3 (f (- n 3)))))))

;Iterative process

(define (f-iter a b c count)
  (cond
    ((= count 0) c)
    ((= count 1) b)
    ((= count 2) a)
    (else (f-iter (+ a (* 2 b) (* 3 c)) a b (- count 1)))))


(f 25)
;812934961
(f-iter 2 1 0 25)
;812934961
