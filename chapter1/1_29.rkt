#! /usr/bin/env racket
#lang racket

(define (integral f a b n)
  (define h (/ (- b a) n))
  (define (add-h x) (+ x h))
  (* (/ h 3) (sum-alt f a add-h b n 0)))

(define (sum-alt term a next b n count)
  (if (> a b)
      0
      (+ (if (or (= count 0) (= count n)) (term a) (if (odd? count) (* 4 (term a)) (* 2 (term a))))
         (sum-alt term (next a) next b n (+ count 1)))))

(define (cube x)
  (* x x x))

(integral cube 0 1 100)

(integral cube 0 1 1000)

;1/4
;1/4


;Although this gave right results, the problem with this implementation is that I changed the definition of sum (which is destroying the purpose of the concept of formulation of abstraction). Upon looking at other implementations online, I figured out that the 'term' procedure could be something different than 'f' procedure. And, instead of implementing 'next' procedure as a method of adding 'kh', it could be a simple incremement procedure. This way it is not necessary to change the definition of sum and preserve the purpose.

;Changed solution:

(define (simpson-integral f a b n)
  (define h (/ (- b a) n))
  (define (coeff k) (if (or (= k 0) (= k n)) 1 (if (odd? k) 4 2)))
  (define (term k) (* (coeff k) (f (+ a (* k h)))))
  (* (/ h 3) (sum term 0 inc n)))

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (inc x)
  (+ x 1))

(simpson-integral cube 0 1 100)

(simpson-integral cube 0 1 1000)

;1/4
;1/4


;Note: Choosing n as 100 and 1000 did not give any different in result.
