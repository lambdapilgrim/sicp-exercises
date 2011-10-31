#! /usr/bin/env racket
#lang racket

(define (reverse l)
  (if (null? l)
      '()
      (append (reverse (cdr l)) (list (car l)))))

(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))

(define (deep-reverse l)
  (cond 
    ((null? l) '())
    ((not (pair? l)) l)
    (else (append (deep-reverse (cdr l)) (list (deep-reverse (car l)))))))


(reverse (list 1 2 3 4 5))
(reverse (list 2 9 (list 3 6 1) 4 13))
(deep-reverse (list 1 2 3 4 5))
(deep-reverse (list 2 9 (list 3 6 1) 4 13))

;'(5 4 3 2 1)
;'(13 4 (3 6 1) 9 2)
;'(5 4 3 2 1)
;'(13 4 (1 6 3) 9 2)

