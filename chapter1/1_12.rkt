#! /usr/bin/env racket
#lang racket

(define (pascal row col)
  (if (or (= row col) (= col 0)) 1
      (+ (pascal (- row 1) (- col 1)) (pascal (- row 1) col))))

(pascal 0 0)
;1
(pascal 2 1)
;2
(pascal 4 3)
;4
(pascal 4 2)
;6
