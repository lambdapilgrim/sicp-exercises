#! /usr/bin/env racket
#lang racket

;mobile -> branch . branch
;branch -> length . structure
;structure -> number|mobile
;length -> number

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (car (cdr mobile)))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (car (cdr branch)))

(define (total-weight mobile)
  (if (not (pair? mobile))
      mobile
      (+ (total-weight (branch-structure (left-branch mobile))) (total-weight (branch-structure (right-branch mobile))))))

(define (balanced? mobile)
  (if (number? mobile)
      #t
      (let
          ((left-length (branch-length (left-branch mobile)))
           (right-length (branch-length (right-branch mobile)))
           (left-weight (total-weight (branch-structure (left-branch mobile))))
           (right-weight (total-weight (branch-structure (right-branch mobile)))))
        (and (= (* left-length left-weight)(* right-length right-weight))
             (balanced? (branch-structure (left-branch mobile)))
             (balanced? (branch-structure (right-branch mobile)))))))

(define x (make-mobile (make-branch 2 (make-mobile (make-branch 2 3)(make-branch 1 6))) (make-branch 3 6)))
(define y (make-mobile (make-branch 6 9) (make-branch 3 6)))

(total-weight x)
(balanced? x)
(total-weight y)
(balanced? y)

;Result:
;15
;#t
;15
;#f


;Changing the representation of mobiles to cons;

;(define (make-mobile left right)
;  (cons left right))
;(define (make-branch length structure)
;  (cons length structure))

;only requires me to change the following selectors:
;(car (cdr mobile)) to (cdr mobile)
;(car (cdr branch)) to (cdr branch)
