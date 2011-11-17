#! /usr/bine/env racket
#lang racket

;The initial procedure of 2.42 generates a linear recursive process:

;Each call of queen-cols calls one more queen-cols until the parameter k becomes
;0. For each call of queens-col, the inner method adjoin-position is called
;board-size number of times.

;(verified by putting a display call inside body of queen-cols, as expected for
;board-size of 8, queen-cols in only called 9 times.)

;Louis Reasoner's procedure generates a tree-recursive process:
