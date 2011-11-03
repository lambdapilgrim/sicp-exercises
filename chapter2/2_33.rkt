#! /usr/bin/env racket
#lang racket

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) '() sequence))

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

(define (length sequence)
  (accumulate (lambda (x y) (+ 1 y)) 0 sequence))

(map (lambda(x) (* x x)) (list 1 2 3 4))

(append (list 1 2 3 4) (list 5 6 7 8))

(length (list 2 34 45 6 9))

;'(1 4 9 16)
;'(1 2 3 4 5 6 7 8)
;5
