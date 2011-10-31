#! /usr/bin/env racket
#lang racket

(define (same-parity . l)
  (if (even? (car l))
      (return-parity l even?)
      (return-parity l odd?)))

(define (return-parity l parity?)
  (cond
    ((null? l) l)
    ((parity? (car l)) (cons (car l) (return-parity (cdr l) parity?)))
    (else (return-parity (cdr l) parity?))))

(same-parity 2 3 5 6 4 3 21 5 65 6)
(same-parity 5 3 2 3 4 5 6343 213 3 45)

;'(2 6 4 6)
;'(5 3 3 5 6343 213 3 45)
