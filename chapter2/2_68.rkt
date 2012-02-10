#!/usr/bin/env racket
#lang racket

(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

(define (leaf? object)
  (eq? (car object) 'leaf))

(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))

(define (left-branch tree) (car tree))

(define (right-branch tree) (cadr tree))

(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (element-of? symbol symbols)
  (cond ((null? symbols) #f)
        ((eq? (car symbols) symbol) #t)
        (else (element-of? symbol (cdr symbols)))))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (encode-symbol symbol tree)
  (define (encode-symbol-aux tree enc-string)
    (cond ((not (element-of? symbol (symbols tree))) (error "symbol not in tree -- ENCODE-SYMBOL" symbol))
          ((leaf? tree) enc-string)
          (else 
           (cond ((element-of? symbol (symbols (left-branch tree))) (encode-symbol-aux (left-branch tree) (append enc-string (list 0))))
                 (else (encode-symbol-aux (right-branch tree) (append enc-string (list 1))))))))
  (encode-symbol-aux tree '()))

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree (make-leaf 'D 1)
                                   (make-leaf 'C 1)))))

(encode '(A D A B B C A) sample-tree)

;Result:
;'(0 1 1 0 0 1 0 1 0 1 1 1 0)
