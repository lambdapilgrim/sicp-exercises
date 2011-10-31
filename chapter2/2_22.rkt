#! /usr/bin/env racket
#lang racket

(define square (lambda (x) (* x x)))
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things) 
              (cons (square (car things))
                    answer))))
  (iter items '()))

(square-list '(2 3 4 6 21 32))

;'(1024 441 36 16 9 4)

;The list is reversed as opposed to intended because in the following call of
;iter:

;(iter (cdr things) 
;              (cons (square (car things))
;                    answer))

;the square of first element of the list is pushed on to answers, which leaves
;the first item of the rest of the list to be paired with answers in this
;order: (cons (same-procedure (cdr items)) (car items))

(define (square-list-alt items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square (car things))))))
  (iter items '()))

(square-list-alt (list 431 12 41 35 13 1 2))

;'(((((((() . 185761) . 144) . 1681) . 1225) . 169) . 1) . 4)

;This is the same problem I saw in reversing the list exercise of 2.18. Although
;the elements in the end of list are being placed after the element in the
;beginning of the list, the cons procedure is being applied in this manner:
;(cons listItem singleItem)
;where listItem already has the list structure of
;(cons singleItem (cons singleItem (cons singleItem ...))).
;This is why we see the above result.
