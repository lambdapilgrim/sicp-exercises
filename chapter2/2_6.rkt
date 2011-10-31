#! /usr/bin/env racket
#lang racket

(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

;To represent one

;(define one (add-1 zero))
;Performing substitution 
;(lambda(f) (lambda (x) (f ((zero f) x))))
;(lambda(f) (lambda (x) (f ((lambda (x) x) x))))
;(lambda(f) (lambda (x) (f x)))

(define one
  (lambda(f) (lambda (x) (f x))))

;To represent two

;(define two (add-1 one))
;Performing substitution
;(lambda(f) (lambda (x) (f ((one f) x))))
;(lambda(f) (lambda (x) (f ((lambda (x) (f x)) x))))
;(lambda(f) (lambda (x) (f (f x))))

(define two
  (lambda (f) (lambda (x) (f (f x)))))

(define inc (lambda (x) (+ 1 x)))

;Took hint from Ken Dyck's blog for add function
(define (+ num1 num2)
  (lambda (f) (lambda (x) ((num2 f)((num1 f) x)))))

;This exercise really squeezed my mind. Church numerals are just 'transient'
;entities that live in the memory as procedure definitions while the process
;that deals with these numerals is alive.

;Zero is a procedure(1). The procedure(1) takes an input(f), and returns a
;procedure(2). The procedure(2) takes an input(x) and returns x. So, zero
;doesn't apply f to x at all.

;One is a procedure(1). The procedure(1) takes an input(f), and returns a
;procedure(2). The procedure(2) takes an input(x) and returns the value of
;procedure f applied over x.

;Each next number (two, three etc.) is a procedure that takes as input a
;procedure(f), and returns as its value another procedure which takes an
;input(x), and applies f over the input as many times as the number(two,
;three etc.) represtents.

;So, to test Church numerals, we can give as input to these numerals(which
;are essentially procedures), a procedure(1). This will return a procedure
;which when given the input(x) will apply the procedure(1) on x, the given
;number of times.

;Therefore:
;((two exp)2) will result in (exp (exp 2))
;((three inc) 9) will output (inc (inc (inc 9))) = 12
((two exp) 2)
;1618.1779919126543

;Addition is application of the procedure num1 on input procedure f (which
;gives a procedure) which is applied on x. This result is input to the procedure
; that's the result of application of num2 on f.

(((+ two one) exp) 0)
;15.154262241479262
