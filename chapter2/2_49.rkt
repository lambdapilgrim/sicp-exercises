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


(define (wave frame)
  ((segments->painter (list (make-segment (make-vector 0 0.9) (make-vector 0.2 0.7))
                           (make-segment (make-vector 0.2 0.7) (make-vector 0.35 0.75))
                           (make-segment (make-vector 0.35 0.75) (make-vector 0.4 0.75))
                           (make-segment (make-vector 0.4 0.75) (make-vector 0.35 0.9))
                           (make-segment (make-vector 0.35 0.9) (make-vector 0.4 1))
                           (make-segment (make-vector 0.6 1) (make-vector 0.65 0.9))
                           (make-segment (make-vector 0.65 0.9) (make-vector 0.6 0.75))
                           (make-segment (make-vector 0.6 0.75) (make-vector 0.7 0.75))
                           (make-segment (make-vector 0.7 0.75) (make-vector 1 0.4))
                           (make-segment (make-vector 1 0.2) (make-vector 0.65 0.5))
                           (make-segment (make-vector 0.65 0.5) (make-vector 0.7 0))
                           (make-segment (make-vector 0.6 0) (make-vector 0.5 0.4))
                           (make-segment (make-vector 0.5 0.4) (make-vector 0.4 0))
                           (make-segment (make-vector 0.3 0) (make-vector 0.35 0.6))
                           (make-segment (make-vector 0.35 0.6) (make-vector 0.3 0.7))
                           (make-segment (make-vector 0.3 0.7) (make-vector 0.2 0.5))
                           (make-segment (make-vector 0.2 0.5) (make-vector 0 0.75))))
   frame))
