#! /usr/bin/env racket
#lang racket

(define (make-interval a b) (cons a b))
(define (lower-bound c) (car c))
(define (upper-bound c) (cdr c))

(define (make-center-percent c p)
  (define (make-lower-bound c p)
    (- c (* c (/ p 100))))
  (define (make-upper-bound c p)
    (+ c (* c (/ p 100))))
  (make-interval (make-lower-bound c p)
                 (make-upper-bound c p)))

(define (center x)
  (/ (+ (upper-bound x) (lower-bound x)) 2))

(define (percent x)
  (let
      ((center (/ (+ (upper-bound x) (lower-bound x)) 2))
       (lb (lower-bound x))
       (ub (upper-bound x)))
    (* (/ (- ub center) center) 100)))

(define (pos? n)
  (> n 0))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))

(define (mul-interval x y)
  (let
      ((lx (lower-bound x))
       (ux (upper-bound x))
       (ly (lower-bound y))
       (uy (upper-bound y))
       (pos-lx? (pos? (lower-bound x)))
       (pos-ux? (pos? (upper-bound x)))
       (pos-ly? (pos? (lower-bound y)))
       (pos-uy? (pos? (upper-bound y))))
    (cond
      ;; Following 9 are the valid cases for the intervals i.e. other possible cases require lower bound to be
      ;; greater than upper bound, so they are ommitted
      ((and pos-lx? pos-ux? pos-ly? pos-uy?) (make-interval (* lx ly) (* ux uy)))
      ((and pos-lx? pos-ux? (not pos-ly?) pos-uy?) (make-interval (* ux ly) (* ux uy)))
      ((and pos-lx? pos-ux? (not pos-ly?) (not pos-uy?)) (make-interval (* ux ly) (* lx uy)))
      ((and (not pos-lx?) pos-ux? pos-ly? pos-uy?) (make-interval (* lx uy) (* ux uy)))
      ((and (not pos-lx?) pos-ux? (not pos-ly?) pos-uy?) (make-interval (min (* ux ly) (* lx uy)) (max (* lx ly) (* ux uy)))) ;;Requires more than 2 multiplications
      ((and (not pos-lx?) pos-ux? (not pos-ly?) (not pos-uy?)) (make-interval (* ux ly) (* lx ly)))
      ((and (not pos-lx?) (not pos-ux?) pos-ly? pos-uy?) (make-interval (* lx uy) (* ux ly)))
      ((and (not pos-lx?) (not pos-ux?) (not pos-ly?) pos-uy?) (make-interval (* lx uy) (* lx ly)))
      ((and (not pos-lx?) (not pos-ux?) (not pos-ly?) (not pos-uy?)) (make-interval (* ux uy) (* lx ly)))
      )))

(define (div-interval x y)
  (if (and (< (lower-bound y) 0) (> (upper-bound y) 0))
      (error "Interval spans over 0" y)
      (mul-interval x 
                    (make-interval (/ 1.0 (upper-bound y))
                                   (/ 1.0 (lower-bound y))))))

(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1))) 
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))

(define a (make-center-percent 5 6))
(define b (make-center-percent 4 5))

(center (par1 a b))
(percent (par1 a b))
(center(par2 a b))
(percent (par2 a b))

;Result:
;2.2494117647058824
;16.422594142259424
;2.2221671826625387
;5.444716897012931

;Results are different in both cases. In fact, the interval formed by par1 procedure has much higher percentage of width, that's because there are more operations on the intervals themselves.

;Investigating more arithmetic expressions on different intervals

(define d (make-center-percent 6 7))
(define e (make-center-percent 10 5))
(define f (make-center-percent 9 3))

(define g (div-interval d e))
(define h (div-interval e e))
(define i (div-interval f e))

(center g)
(percent g)
(center h)
(percent h)
(center i)
(percent i)

;Result
;0.6036090225563909
;11.958146487294472
;1.0050125313283207
;9.975062344139651
;0.9036090225563909
;7.988017973040443

