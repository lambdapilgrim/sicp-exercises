#! /usr/bin/env racket
#lang racket

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

(define (make-point x y)
  (cons x y))

(define (corner-point1 rect)
  (car rect))

(define (corner-point2 rect)
  (cdr rect))

(define (make-rect cp1 cp2)
  (cons cp1 cp2))

;(define (corner-point1 rect)
;  (cdr rect))

;(define (corner-point2 rect)
;  (car rect))

;(define (make-rect cp1 cp2)
;  (cons cp2 cp1))

(define (area rect)
  (let ((cp1 (corner-point1 rect)) (cp2 (corner-point2 rect)))
    (let ((cp1x (x-point cp1)) (cp2x (x-point cp2)) (cp1y (y-point cp1)) (cp2y (y-point cp2)))
      (* (abs (- cp1x cp2x)) (abs (- cp1y cp2y))))))

(define (perimeter rect)
  (let ((cp1 (corner-point1 rect)) (cp2 (corner-point2 rect)))
    (let ((cp1x (x-point cp1)) (cp2x (x-point cp2)) (cp1y (y-point cp1)) (cp2y (y-point cp2)))
      (* 2 (+ (abs (- cp1x cp2x)) (abs (- cp1y cp2y)))))))

(define p1 (make-point 2 3))
(define p2 (make-point 1 2))
(define p3 (make-point -21 2))
(define p4 (make-point -5 16))
(define r1 (make-rect p1 p2))
(define r2 (make-rect p3 p4))

(area r1)
(perimeter r1)
(area r2)
(perimeter r2)

;1
;4
;224
;60


;I chose to represent a rectangle using two corner points. In the first representation, I chose first corner point as the first member of the pair and the second corner point, the second member. In the alternative representation of the rectangle, I chose first corner point as the second member of the pair and the second corner point as the first member.

;In both these cases, I used the same implementation of area and perimeter with the same constructors and selectors, the results were the same.
