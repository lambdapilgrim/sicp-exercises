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



(timed-prime-test 1009)
(timed-prime-test 1013)
(timed-prime-test 1019)
(timed-prime-test 10007)
(timed-prime-test 10009)
(timed-prime-test 10037)
(timed-prime-test 100003)
(timed-prime-test 100019)
(timed-prime-test 100043)
(timed-prime-test 1000003)
(timed-prime-test 1000033)
(timed-prime-test 1000037)



;1009 is prime. Time taken: -0.01220703125
;1013 is prime. Time taken: -0.0009765625
;1019 is prime. Time taken: -0.0009765625
;10007 is prime. Time taken: -0.0009765625
;10009 is prime. Time taken: -0.0009765625
;10037 is prime. Time taken: 0.0
;100003 is prime. Time taken: -0.0009765625
;100019 is prime. Time taken: -0.0009765625
;100043 is prime. Time taken: 0.0
;1000003 is prime. Time taken: -0.001220703125
;1000033 is prime. Time taken: -0.0009765625
;1000037 is prime. Time taken: -0.0009765625



;These times don't make sense. I guess there is something wrong with the procedure current-inexact-milliseconds.
