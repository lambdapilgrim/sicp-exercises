#! /usr/bin/env racket
#lang racket

;Theta = (1 + sqrt(5))/2
;Phi = (1 - sqrt(5))/2

;Fib(0) = 0
;Fib(1) = (Theta - Phi)/sqrt(5) = 1

;Let's assume that it is true for n = k.

;So,
;Fib(k) = (Theta ^ k - Phi ^ k)/(sqrt 5)
;Fib(k-1) = ((Theta ^ (k - 1)) - (Phi ^ (k - 1)))/(sqrt 5)

;Fib(k) + Fib(k-1) = (Theta ^ k - Phi ^ k)/(sqrt 5) + ((Theta ^ (k - 1)) - (Phi ^ (k - 1)))/(sqrt 5)

;Using Binomial theorem:

;Fib(k) + Fib(k-1) = Fib(k+1)

;(proved on paper)
