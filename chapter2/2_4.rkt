#! /usr/bin/env racket
#lang racket

(define (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda (p q) p)))

(define (cdr z)
  (z (lambda (p q) q)))

(car (cons 5 4))
(cdr (cons 5 4))

;5
;4

;To verify this works, applying substitution model (applicative order):
;(car (cons 5 4))
;((cons 5 4) (lambda (p q) p))
;((lambda (m) (m 5 4)) (lambda (p q) p))
;((lambda (p q) p) 5 4)
;5

;(cdr (cons 5 4))
;((cons 5 4) (lambda (p q) q))
;((lambda (m) (m 5 4)) (lambda (p q) q))
;((lambda (p q) q) 5 4)
;4
