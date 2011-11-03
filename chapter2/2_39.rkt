#! /usr/bin/env racket
#lang racket

(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op initial (cdr sequence)))))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))

(define (reverse-fr sequence)
  (fold-right (lambda (x y) (append y (list x))) '() sequence))


(define (reverse-fl sequence)
  (fold-left (lambda (x y) (append (list y) x)) '() sequence))

(reverse-fr (list 4 56 6 4 2))
(reverse-fl (list 4 56 6 4 2))

;Result:
;'(2 4 6 56 4)
;'(2 4 6 56 4)
