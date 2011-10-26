#! /usr/bin/env racket
#lang racket

(define (composee f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (if (= n 1)
      f
      (composee f (repeated f (- n 1)))))

(define tolerance 0.000001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (average-damp f)
  (lambda (x) (/ (+ x (f x)) 2)))

(define (nthrt x n)
  (fixed-point ((repeated average-damp (floor (/ (log n) (log 2)))) (lambda (y) (/ x (expt y (- n 1))))) 1.0))


(nthrt 4 2)
(nthrt 8 3)
(nthrt 16 4)
(nthrt 32 5)
(nthrt 64 6)
(nthrt 128 7)
(nthrt 256 8)
(nthrt 512 9)
(nthrt 1024 10)
(nthrt 2048 11)
(nthrt 4096 12)
(nthrt 8192 13)
(nthrt 16384 14)
(nthrt 32768 15)
(nthrt 65536 16)

;2.000000000000002
;2.0000002271906077
;2.0
;2.0000000945616985
;2.0000001833403775
;2.0000003557852426
;2.0
;2.0000000361646872
;2.0000000739374078
;2.0000001265301037
;2.000000288570333
;1.9999997226217827
;1.9999996322344142
;1.999999576942575
;2.0

;Experimenting with the number of times average-damp needs to be repeated to calculate nth root of a number, it is clear that in order to converge the solution, average damp must be repeated log n to the base 2 times, rounded off to the lower integer.

;Meaning:
;To calculate upto 3rd roots, 1 avaerage-damp is enough.
;To calculate 4th to 7th roots, 2 average-damps are required.
;To calculate 8th to 15th roots, 3 average-damps are required.


;I used (floor (/ (log n) (log 2))) to get that number.
