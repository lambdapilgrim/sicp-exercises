#! /usr/local/bin/racket
#lang racket

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
  
;Based on whether b is negative or not, the right operator is used to oeprate on
;a and b. An addition on a and b will be performed if b is a positive number,
;else subtraction of a and b will be performed.

(a-plus-abs-b 5 6)

(a-plus-abs-b 3 -4)

;Result:
;11
;7
