#! /usr/bin/env racket
#lang racket

(define (square x)
  (* x x))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

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

(define (search-for-primes start-range end-range)
  (if (< start-range (- end-range 2))
      ((timed-prime-test start-range)
       (search-for-primes (+ start-range 2) end-range))
      (display "Test over")))

;(search-for-primes 1195 1199)

;First 3 primes greater than 1000:
;1009 is prime. Time taken: 0.009765625
;1013 is prime. Time taken: 0.009033203125
;1019 is prime. Time taken: 0.009033203125

;(search-for-primes 9999 11000)
;First 3 primes greater than 10000:
;10007 is prime. Time taken: 0.027099609375
;10009 is prime. Time taken: 0.029052734375
;10037 is prime. Time taken: 0.028076171875

;(search-for-primes 99999 100100)
;First 3 primes greater than 100000:
;100003 is prime. Time taken: 0.048828125
;100019 is prime. Time taken: 0.08203125
;100043 is prime. Time taken: 0.085205078125

;(search-for-primes 999999 1000100)
;First 3 primes greater than 1000000:
;1000003 is prime. Time taken: 0.156982421875
;1000033 is prime. Time taken: 0.27197265625
;1000037 is prime. Time taken: 0.258056640625


;Comparison of times taken for 1009 and 10007 = 2.775
;Comparison of times taken for 100003 and 1000003 = 3.215
;Value of sqrt(10) = 3.16
