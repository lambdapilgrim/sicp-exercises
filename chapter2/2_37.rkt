#! /usr/bin/env racket
#lang racket

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      '()
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (lambda(x) (dot-product v x)) m))

(define (transpose mat)
  (accumulate-n cons '() mat))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda(m-row)(matrix-*-vector cols m-row)) m)))

(dot-product (list 2 3 ) (list 2 3))
(matrix-*-vector (list (list 2 4 5) (list 2 6 4)) (list 1 2 1))
(transpose (list (list 2 4 5) (list 2 6 4)))
(matrix-*-matrix (list (list 2 4) (list 2 6)) (list (list 2 4) (list 2 6)))

;13
;'(15 18)
;'((2 2) (4 6) (5 4))
;'((12 32) (16 44))
