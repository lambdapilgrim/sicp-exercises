#! /usr/bin/env racket
#lang racket

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

(define (enumerate-interval m n)
  (if (> m n)
      '()
      (cons m (enumerate-interval (+ m 1) n))))

(define (triplets n)
  (flatmap
   (lambda (i)
     (flatmap
      (lambda (j)
        (map (lambda (k) (list i j k)) (enumerate-interval 1 j)))
      (enumerate-interval 1 i)))
   (enumerate-interval 1 n)))

;Note on triplets:
;I first ended up generating triplets as a sequence of sequences of sequences
;(undesirable as I need a sequence of flat lists), because I was not using
;flatmap first to generate a sequence of pairs and not using nested flatmap to
;generate the triplets. Later, I applied nested flatmap to do that.

(define (sum? triplet s)
  (= (+ (car triplet) (cadr triplet) (caadr triplet)) s))

(define (triplet-sum n s)
  (filter
   (lambda (triplet) (= (+ (car triplet) (car(cdr triplet)) (car (cdr (cdr triplet)))) s))
   (triplets n)))

(triplet-sum 10 16)

;Result:
;'((6 5 5) (6 6 4) (7 5 4) (7 6 3) (7 7 2) (8 4 4) (8 5 3) (8 6 2) (8 7 1) (9 4 3) (9 5 2) (9 6 1) (10 3 3) (10 4 2) (10 5 1))
