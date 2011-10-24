#! /usr/bin/env racket
#lang racket

(define (filtered-accumulate predicate combiner null-value term a next b)
  (if (> a b)
      null-value
      (if (predicate a)
          (combiner (term a) (filtered-accumulate predicate combiner null-value term (next a) next b))
          (filtered-accumulate predicate combiner null-value term (next a) next b))))


(define (sum a b predicate term next)
  (define (add x y)(+ x y))
  (filtered-accumulate predicate add 0 term a next b))

(define (product a b predicate term next)
  (define (multiply x y)(* x y))
  (filtered-accumulate predicate multiply 1 term a next b))

;; Part a
(define (sum-of-prime-squares a b)
  (sum a b prime? square inc))

;;Part b
(define (product-of-pos-nums-prime-to-n n)
  (define (product-of-pos-nums-prime-to-n-aux a b)
    (define (relative-prime? x)
      (= (gcd x b) 1))
    (product a b relative-prime? iden inc))
  (product-of-pos-nums-prime-to-n-aux 1 n))

(define (inc x)
  (+ x 1))

(define (iden x)
  x)

(define (square x)
  (* x x))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (prime? n)
  (fast-prime? n 5))

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(sum-of-prime-squares 2 15)
(product-of-pos-nums-prime-to-n 8)

;377
;105
