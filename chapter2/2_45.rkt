#! /usr/bin/env racket
#lang racket

(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

(define (split pos1 pos2)
  (lambda (painter n)
    (if (= n 0)
        painter
        (let ((smaller ((split pos1 pos2) painter (- n 1))))
          (pos1 painter (pos2 smaller smaller))))))

(define right-split (split beside below))
(define up-split (split below beside))



(paint (right-split einstein 4))
(paint (up-split einstein 1))

;Result:
;File 2_45_rightsplit.jpg
;File 2_45_upsplit.jpg
