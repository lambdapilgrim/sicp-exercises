#! /usr/bin/env racket
#lang racket

(define (make-interval a b) (cons a b))
(define (lower-bound c) (car c))
(define (upper-bound c) (cdr c))

(define (pos? n)
  (> n 0))

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

(mul-interval (make-interval 1 2) (make-interval 5 6))
(mul-interval (make-interval 1 2) (make-interval -1 4))
(mul-interval (make-interval 3 4) (make-interval -4 -3))
(mul-interval (make-interval -2 3) (make-interval 5 6))

;;These 2 examples are for case 5 covering both possible values
(mul-interval (make-interval -2 3) (make-interval -6 2))
(mul-interval (make-interval -6 3) (make-interval -6 2))

(mul-interval (make-interval -2 3) (make-interval -6 -5))
(mul-interval (make-interval -3 -2) (make-interval 5 7))
(mul-interval (make-interval -4 -3) (make-interval -2 4))
(mul-interval (make-interval -4 -3) (make-interval -7 -6))

;'(5 . 12)
;'(-2 . 8)
;'(-16 . -9)
;'(-12 . 18)
;'(-18 . 12)
;'(-18 . 36)
;'(-18 . 12)
;'(-21 . -10)
;'(-16 . 8)
;'(18 . 28)
