#! /usr/bin/racket
#lang racket

;When selectors like 'real-part and 'imag-part are installed in the number package on the highest level, a link is created between numbers in the outside world, and actual selectors in complex number package.

(magnitude z)

(apply-generic 'magnitude z)

((get 'magnitude '(complex)) '(rectangular (3 . 4)))

(magnitude '(rectangular (3 4)))

(apply-generic 'magnitude '(rectangular (3 . 4)))

((get 'magnitude '(rectangular)) (3 . 4))

;This finally gives the procedure that extracts magnitude from a complex number reprented in rectangular format.

