#! /usr/bin/env racket
#lang racket

(car ''abracadabra)

;Result:
;'quote

;As mentioned in the footnote# 34, ' is just an abbreviation for the special form 'quote'.
;To evaluate (car ''abracadabra), the interpreter sees it as (car (quote (quote abracadabra))).
;This gets evaluated as (list 'car (list 'quote '(a b c))).

;Note: I tried evaluating (car (define x 5)), but it gives an error because define is not
;allowed in an expression context.