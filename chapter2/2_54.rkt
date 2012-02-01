#! /usr/bin/env racket
#lang racket

(define (equal? list1 list2)
  (if (not (and (pair? list1) (pair? list2)))
      (eq? list1 list2)
      (and (equal? (car list1) (car list2))(equal? (cdr list1) (cdr list2)))))

(equal? '(this is a list) '(this (is a) list))
(equal? '(this is a list) '(this is a list))

;Result:
;#f
;#t