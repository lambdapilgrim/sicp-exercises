#! /usr/bin/racket
#lang racket

(define (make-from-mag-ang x y)
  (define (dispatch op)
    (cond ((eq? op 'real-part)
	   (* x (cos y)))
	  ((eq? op 'imag-part)
	   (* x (sin y)))
	  ((eq? op 'magnitude) x)
	  ((eq? op 'angle) y)
	  (else 
	   (error "Uknown op -- MAKE-FROM-MAG-ANG" op))))
  dispatch)

(define (apply-generic op arg) (arg op))

(apply-generic 'real-part (make-from-mag-ang 10 (/ 3.14 2)))
(apply-generic 'imag-part (make-from-mag-ang 10 (/ 3.14 2)))

;0.007963267107332634
;9.999996829318347




