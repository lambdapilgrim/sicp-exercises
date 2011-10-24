#! /usr/bin/env racket
#lang racket

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square-check (expmod base (/ exp 2) m) m)
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))        

(define (miller-rabin-test n)
  (define (try-it a)
    (= (expmod a (- n 1) n) 1))
  (try-it (+ 1 (random (- n 1)))))

(define (square-check x n)
  (if (and (not (or (= x 1) (= x (- n 1)))) (= (remainder (* x x) n) 1)) 0
  (* x x)))

(miller-rabin-test 561)
(miller-rabin-test 1105)
(miller-rabin-test 1729)
(miller-rabin-test 2465)
(miller-rabin-test 2821)
(miller-rabin-test 6601)

;#f
;#f
;#f
;#f
;#f
;#f
