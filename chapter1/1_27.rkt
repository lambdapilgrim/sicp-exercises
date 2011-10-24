#! /usr/bin/env racket
#lang racket

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (fermat-test n)
  (newline)
  (display n)
  (fermat-test-iter n (- n 1)))

(define (fermat-test-iter n a)
  (cond ((= a 0) true)
        ((= (expmod a n n) a) (fermat-test-iter n (- a 1)))
        (else false)))

(define (square x)
  (* x x))

(define (timed-prime-test n)
  (start-prime-test n (current-inexact-milliseconds)))

(define (start-prime-test n start-time)
  (if (fermat-test n)
      (report-prime (- (current-inexact-milliseconds) start-time))
      (report-non-prime)))

(define (report-non-prime)
  (display " is not prime."))

(define (report-prime elapsed-time)
  (display " is prime. Time taken: ")
  (display elapsed-time))



(timed-prime-test 561)
(timed-prime-test 1105)
(timed-prime-test 1729)
(timed-prime-test 2465)
(timed-prime-test 2821)
(timed-prime-test 6601)


;561 is prime. Time taken: -0.041015625
;1105 is prime. Time taken: -0.003173828125
;1729 is prime. Time taken: -0.0009765625
;2465 is prime. Time taken: -0.001953125
;2821 is prime. Time taken: -0.001953125
;6601 is prime. Time taken: -0.001953125
