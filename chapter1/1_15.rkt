#! /usr/bin/env racket
#lang racket

(define (cube x) (* x x x))
(define (p x) (- (* 3 x) (* 4 (cube x))))
(define (sine angle)
   (if (not (> (abs angle) 0.1))
       angle
       (p (sine (/ angle 3.0)))))


(sine (/ 3.14 2))
;0.9999999959705563
(sine (/ 3.14 3))
;0.8658910929629984

;For calcualtion of (sine 12.15)
;(sine 12.15)
;= (p (sine 4.05))
;= (p (p (sine 1.35)))
;= (p (p (p (sine 0.45))))
;= (p (p (p (p (sine 0.15)))))
;= (p (p (p (p (p (sine 0.05))))))
;= (p (p (p (p (p 0.05)))))

;p is applied 5 times while calculating (sine 12.15)

;Order of growth in space and number of steps:

;Each time, the value of the argument(whose sine is to be calculated) is divided by 3 until it is less than 0.1. So, it takes log a to the base 3 times to reduce the number to 1. To reduce 1 to 0.1, it takes additional 3 steps. This means that the total number of steps will grow as log3(a).

;Also the total number of operations to be performed later to keep track of grows logarithmically with n.

;Therefore, both space and time complexity are log(a)
