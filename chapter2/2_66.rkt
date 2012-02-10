#!/usr/bin/env racket
#lang racket

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))

(define (key record)
  (car record))

(define (lookup given-key set-of-records)
  (cond ((null? set-of-records) false)
        ((= given-key (key (entry set-of-records)))
         (entry set-of-records))
        ((< given-key (key (entry set-of-records)))
         (lookup given-key (left-branch set-of-records)))
        (else (lookup given-key (right-branch set-of-records)))))


(define a-set-of-records '((2 a) ((1 b) () ()) ((3 c) () ())))

(lookup 1 a-set-of-records)
(lookup 5 a-set-of-records)

;'(1 b)
;#f
