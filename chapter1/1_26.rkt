#! /usr/bin/env racket
#lang racket

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (* (expmod base (/ exp 2) m)
                       (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))


;In this function, the calculation of b ^ e/2 happens twice for each b and e. This way the number of steps, taken at each step is exponential to the depth of the tree. For example, if the tree has a depth of 3 (for the input of size 8) at any given node, the number of steps becomes 2 ^ (log 8) = 8.

;Thus, linear time.
