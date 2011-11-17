#! /usr/bin/env racket
#lang racket

(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line
        ((frame-coord-map frame) (start-segment segment))
        ((frame-coord-map frame) (end-segment segment))))
     segment-list)))

(define (outline frame)
  ((segments->painter (list (make-segment (make-vector 0 0) (make-vector 0 1))
                            (make-segment (make-vector 0 1) (make-vector 1 1))
                            (make-segment (make-vector 1 1) (make-vector 1 0))
                            (make-segment (make-vector 1 0) (make-vector 0 0)))) frame))

(define (x-outline frame)
  ((segments->painter (list (make-segment (make-vector 0 0) (make-vector 1 1))
                            (make-segment (make-vector 1 0) (make-vector 0 1)))) frame))


(define (diamond frame)
  ((segments->painter (list (make-segment (make-vector 0.5 0) (make-vector 0 0.5))
                            (make-segment (make-vector 0 0.5) (make-vector 0.5 1))
                            (make-segment (make-vector 0.5 1) (make-vector 1 0.5))
                            (make-segment (make-vector 1 0.5) (make-vector 0.5 0)))) frame))
