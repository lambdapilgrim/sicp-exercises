#! /usr/bin/env racket
#lang racket

(define (f g)
  (g 2))

;If we ask the interpreter to compute (f f), first f will be called with f as an argument, which will trigger a call of (f 2), which will trigger a call of (2 2). At this point the interpreter will complain that 2 is not a procedure.

(f f)
;procedure application: expected procedure, given: 2; arguments were: 2
