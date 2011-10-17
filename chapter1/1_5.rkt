#! /usr/local/bin/racket
#lang racket

(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))

(test 0 (p))
;If the interpreter uses normal-order evaluation, then the execution will
;complete with answer 0. If it uses applicative-order evaluation, then the
;process will not terminate.

;This is because in applicative order evaluation, the operands are first
;evaluated before the operator is applied on them. Since evaluation of (p)
;will be performed in this case, the process will never terminate. On the
;other hand, normal-order evaluation("fully expand and then reduce") will
;yield to the if expression, which readily reduces to 0. As per the assumption
;in the question, evaluation rule for if is that the predicate is evaluated
;first, if it evaluates to true, consequent is returned and alternative is not
;evaluated.
