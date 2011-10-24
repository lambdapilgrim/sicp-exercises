#! /usr/bin/env racket
#lang racket

(define (expmod base exp m)
  (remainder (fast-expt base exp) m))

(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (square x)
  (* x x))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (current-inexact-milliseconds)))

(define (start-prime-test n start-time)
  (if (fast-prime? n 5)
      (report-prime (- (current-inexact-milliseconds) start-time))
      (report-non-prime)))

(define (report-non-prime)
  (display " is not prime."))

(define (report-prime elapsed-time)
  (display " is prime. Time taken: ")
  (display elapsed-time))


;Although theoretically fast-expt calculates the exponential in log time, it does so by multiplying successively very large numbers. I confirmed this by doing a timed-prime-test on a large number like 1000033, which took considerably long time.

;In the expmod function (as mentioned in footnote 46), (x times y) mod m is ((x mod m) times (y mod m)) mod m. This function makes sure that the multiplication doesn't happen between any numbers larger than m, hence it is way faster!
