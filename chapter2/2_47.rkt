#! /usr/bin/env racket
#lang racket

(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame frame)
  (car frame))

(define (edge1-frame frame)
  (car (cdr frame)))

(define (edge2-frame frame)
  (car (cdr (cdr frame))))


(define (make-frame-alt origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

(define (origin-frame-alt frame)
  (car frame))

(define (edge1-frame-alt frame)
  (car (cdr frame)))

(define (edge2-frame-alt frame)
  (cdr (cdr frame)))
