#!/usr/bin/env racket
#lang racket

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))


(define tree1 '(7 (3 (1 () ()) (5 () ())) (9 () (11 () ()))))
(define tree2 '(3 (1 () ()) (7 (5 () ()) (9 () (11 () ())))))
(define tree3 '(5 (3 (1 ()() ) ()) (9 (7 () ()) (11 () ()))))

(tree->list-1 tree1)
(tree->list-1 tree2)
(tree->list-1 tree3)
(tree->list-2 tree1)
(tree->list-2 tree2)
(tree->list-2 tree3)

;'(1 3 5 7 9 11)
;'(1 3 5 7 9 11)
;'(1 3 5 7 9 11)
;'(1 3 5 7 9 11)
;'(1 3 5 7 9 11)
;'(1 3 5 7 9 11)

;a The two procedures will produce the same result for all trees.
;b 2nd procedure will be faster because cons is a constant time operation, whereas
;the definition of append in chapter 2 describes it as a linear time operation.
;For 2nd procedure, the number of steps taken will be equal to the number of nodes in
;the tree, so O(n) growth. However, for the 1st procedure, number of steps equal to the 
;length of first list will be spent in the append operation, and this will be done
;for all nodes in the tree, making O(n^2) growth.
