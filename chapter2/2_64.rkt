#!/usr/bin/env racket
#lang racket

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))

(list->tree '(1 3 5 7 9 11))
;'(5 (1 () (3 () ())) (9 (7 () ()) (11 () ())))
;             5
;            / \
;           /   \
;          1     9
;           \   / \
;            3 7   11

;a. partial-tree splits the given list in three parts. First it creates a left tree
;from the first n-1/2 elements by calling partial-tree recursively.
;This consumes half of the elements from the list, which is reflected in non-left-elts.
;From these remaining elements, one element is taken to form the current element
;and the remaining are passed to another recursive call to partial-tree for
;forming right sub-tree. Finally mak-tree is called with the current element, left tree
;and right tree. This is cons'ed with remaining-elts and returned. remaining-elts
;will be used at the call to partial-tree at upper level to form the right tree.

;b. The order of growth will be linear in the number of elements to form the tree.
;Every element is visited exactly once to form the balanced tree.
