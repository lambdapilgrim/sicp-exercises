#! /usr/bin/env racket
#lang racket

;Finding p' and q'

;a = bq + aq + ap
;b = bp + aq

;Applying one transformation:

;a = bq + aq + ap
;= (bp + aq)q + (bq + aq + ap)q + (bq + aq + ap)p
;= bpq + aqq + bqq + aqq + apq + bpq + apq + app
;= b(2pq + qq) + a(2pq + qq) + a (pp + qq)

;b = bp + aq
;= (bp + aq)p + (bq + aq + ap)q
;= bpp + apq + bqq + aqq + apq
;= b(pp + qq) + a(2pq + qq)

;Therefore:

;p' = (pp + qq)
;q' = (2pq + qq)


(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (* p p) (* q q))      ; compute p'
                   (+ (* q q) (* 2 p q))      ; compute q'
                   (/ count 2)))
        (else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))

(fib 8)
;21
(fib 24)
;46368
