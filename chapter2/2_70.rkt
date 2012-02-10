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

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair)    ; symbol
                               (cadr pair))  ; frequency
                    (make-leaf-set (cdr pairs))))))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (element-of? symbol symbols)
  (cond ((null? symbols) #f)
        ((eq? (car symbols) symbol) #t)
        (else (element-of? symbol (cdr symbols)))))

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

(define (successive-merge leaf-set)
  (if (null? (cdr leaf-set))
      (car leaf-set)
      (let ((f-el (car leaf-set)) (s-el (cadr leaf-set)))
        (successive-merge (adjoin-set (make-code-tree f-el s-el) (cddr leaf-set))))))
  
  
(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(generate-huffman-tree '((A 2) (NA 16) (BOOM 1) (SHA 3) (GET 2) (YIP 9) (JOB 2) (WAH 1)))

;Result:
;'((leaf NA 16)
;  ((leaf YIP 9)
;   (((leaf A 2) ((leaf WAH 1) (leaf BOOM 1) (WAH BOOM) 2) (A WAH BOOM) 4) ((leaf SHA 3) ((leaf JOB 2) (leaf GET 2) (JOB GET) 4) (SHA JOB GET) 7) (A WAH BOOM SHA JOB GET) 11)
;   (YIP A WAH BOOM SHA JOB GET)
;   20)
;  (NA YIP A WAH BOOM SHA JOB GET)
;  36)

(define song-huff-tree (generate-huffman-tree '((A 2) (NA 16) (BOOM 1) (SHA 3) (GET 2) (YIP 9) (JOB 2) (WAH 1))))

(encode '(GET A JOB SHA NA NA NA NA NA NA NA NA GET A JOB SHA NA NA NA NA NA NA NA NA WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP SHA BOOM) song-huff-tree)

;Result:
;'(1 1 1 1 1 1 1 0 0 1 1 1 1 0 1 1 1 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 0 0 1 1 1 1 0 1 1 1 0 0 0 0 0 0 0 0 0 1 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 0 1 1)

;84 bits are needed to encode the complete song.
;If fixed lenght codes were used, there will be 3 bits for each symbol (since there are 8 symbols). That will require 36(total number of symbols)*3 = 108 bits to encode the song.
