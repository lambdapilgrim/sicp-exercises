#! /usr/bin/env racket
#lang racket

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))


;Using normal order evaluation for substitution method:

;(gcd 206 40)
;(gcd 40 (remainder 206 40))
;(gcd (remainder 206 40) (remainder 40 (remainder 206 40)))
;(gcd (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
;(gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))
;(remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;(remainder 6 (remainder 40 (remainder 206 40)))
;(remainder 6 (remainder 40 6))
;(remainder 6 4)
;2

;Total number of remainder operations = 14 times inside if procedure + 4 times in gcd procedure = 18 times

;Using applicative order evaluation for substitution model:
;(gcd 206 40)
;(gcd 40 (remainder 206 40))
;(gcd 40 6)
;(gcd 6 (remainder 40 6)
;(gcd 6 4)
;(gcd 4 (remainder 6 4))
;(gcd 4 2)
;(gcd 2 (remainder 4 2))
;(gcd 2 0)
;2

;Total number of remainder operations performed = 4
