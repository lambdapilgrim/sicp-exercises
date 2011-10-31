#! /usr/bin/env racket
#lang racket

;As noted, the interval arithmetic cannot be applied to a all algebraic equivalents
;I am choosing to test (square (+ a b)) = (+ (square a) (square b) (* 2 a b))


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

(define a (make-interval -2 3))
(define b (make-interval -3 -2))

;square(a+b)
(define e (mul-interval (add-interval a b) (add-interval a b)))
(lower-bound e)
(upper-bound e)

;square(a) + square(b) + 2ab
(define f (add-interval (add-interval (mul-interval a a) (mul-interval b b)) (mul-interval (make-interval 2 2) (mul-interval a b))))
(lower-bound f)
(upper-bound f)

;-5
;25
;-20
;30

;As clear from the experiment, they are two completely different answers
