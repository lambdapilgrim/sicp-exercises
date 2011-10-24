#! /usr/bin/env racket
#lang racket

(define (square x)
  (* x x))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(define (next d)
  (if (= 2 d)
      3
      (+ d 2)))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (current-inexact-milliseconds)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (current-inexact-milliseconds) start-time))
      (report-non-prime)))

(define (report-non-prime)
  (display " is not prime."))

(define (report-prime elapsed-time)
  (display " is prime. Time taken: ")
  (display elapsed-time))

(timed-prime-test 1009)
;1009 is prime. Time taken: 0.1591796875

(timed-prime-test 1013)
;1013 is prime. Time taken: 0.005126953125

(timed-prime-test 1019)
;1019 is prime. Time taken: 0.005126953125

(timed-prime-test 10007)
;10007 is prime. Time taken: 0.011962890625

(timed-prime-test 10009)
;10009 is prime. Time taken: 0.010986328125

(timed-prime-test 10037)
;10037 is prime. Time taken: 0.011962890625

(timed-prime-test 100003)
;100003 is prime. Time taken: 0.195068359375

(timed-prime-test 100019)
;100019 is prime. Time taken: 0.033935546875

(timed-prime-test 100043)
;100043 is prime. Time taken: 0.032958984375

(timed-prime-test 1000003)
;1000003 is prime. Time taken: 0.10302734375

(timed-prime-test 1000033)
;1000033 is prime. Time taken: 0.10400390625

(timed-prime-test 1000037)
;1000037 is prime. Time taken: 0.10400390625



;The times for larger numbers confirm the speed to be twice as fast.
