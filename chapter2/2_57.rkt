#! /usr/bin/env racket
#lang racket

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (make-sum . a)
  (cond ((=number? (car a) 0) (make-sum (cdr a)))
        (else (cons '+ a))))

(define (make-product . m)
  (cond ((=number? (car m) 0) 0)        
        ((=number? (car m) 1) (make-product (cdr m)))
        (else (cons '* m))))

(define (make-exponentiation b e)
  (cond ((=number? e 0) 1)
        ((=number? e 1) b)
        (else (list '** b e))))

(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))

(define (addend s) (cadr s))

(define (augend s) 
  (if (null? (cdddr s))
      (caddr s)
      (cons '+ (cddr s))))

(define (product? x)
  (and (pair? x) (eq? (car x) '*)))

(define (multiplier p) (cadr p))

(define (multiplicand p) 
  (if (null? (cdddr p))
      (caddr p)
      (cons '+ (cddr p))))

(define (exponentiation? x)
  (and (pair? x) (eq? (car x) '**)))

(define (base e)
  (cadr e))

(define (exponent e)
  (caddr e))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (deriv (multiplier exp) var)
                         (multiplicand exp))))
        ((exponentiation? exp)
         (let ((b (base exp)) (e (exponent exp)))
           (make-product e (make-product (make-exponentiation b (- e 1)) (deriv b var)))))
        (else
         (error "unknown expression type -- DERIV" exp))))

(deriv '(+ x y (* x (** x 8))) 'x)
;Result:
;'(+ 1 (+ ((+ (* x (* 8 (* (** x 7) 1))) (* ((** x 8)))))))

;Without changing the representation of deriv, it is only possible to reform sums and products
;with at least 2 arguments. Obviously this is not giving out the result in simplest form.
