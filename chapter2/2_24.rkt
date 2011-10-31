#! /usr/bin/env racket
#lang racket

(list 1 (list 2 (list 3 4)))

;Result:
;'(1 (2 (3 4)))

;Breaking into conses to help in box-pointer drawing
;(list 1 (list 2 (cons 3 (cons 4 null))))
;(list 1 (cons 2 (cons (cons 3 (cons 4 null)) null)))
;(cons 1 (cons (cons 2 (cons (cons 3 (cons 4 null)) null)) null))
