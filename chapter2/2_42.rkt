#! /usr/bin/env racket
#lang racket

(define (enumerate-interval m n)
  (if (> m n)
      '()
      (cons m (enumerate-interval (+ m 1) n))))

(define (accumulate proc init seq)
  (if (null? seq)
      init
      (proc (car seq)
            (accumulate proc init (cdr seq)))))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

(define empty-board '())

(define (adjoin-position new-row k rest-of-queens)
  ;I am not sure why k is needed here because new-row is going to be adjoined at position k by definition.
  (append rest-of-queens (list new-row)))

(define (safe? k positions)
  (define (findkthpos k positions)
    (if (= k 1)
      (car positions)
      (findkthpos (- k 1) (cdr positions))))
  
  (define (safe-aux? k i kthrow positions)
    (cond
      ((null? positions) #t)
      ((or
        (and (= kthrow (car positions)) (not (= k i))) ;kth queen and the current queen should not be in the same row
        (and (= (abs (- kthrow (car positions))) (- k i)) (not (= k i)))) #f) ;kth queen and the current queen cannot be diagonally conflicting
      (else (safe-aux? k (+ i 1) kthrow (cdr positions)))))
  
  (let ((kthrow (findkthpos k positions)))
    (safe-aux? k 1 kthrow positions)))
 
   
(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

(queens 4)
(queens 6)

;Result:

;'((2 4 1 3) (3 1 4 2))
;'((2 4 6 1 3 5) (3 6 2 5 1 4) (4 1 5 2 6 3) (5 3 1 6 4 2))
