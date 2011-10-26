#! /usr/bin/env racket
#lang racket

(define (composee f g)
  (lambda (x) (f (g x))))

(define (square x)
  (* x x))

(define (inc x)
  (+ x 1))

((composee square inc) 6)

;49
