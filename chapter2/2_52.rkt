#! /usr/bin/env racket
#lang racket

(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

(define (wave frame)
  ((segments->painter (list (make-segment (make-vector 0 0.9) (make-vector 0.2 0.7))
                           (make-segment (make-vector 0.2 0.7) (make-vector 0.35 0.75))
                           (make-segment (make-vector 0.35 0.75) (make-vector 0.4 0.75))
                           (make-segment (make-vector 0.4 0.75) (make-vector 0.35 0.9))
                           (make-segment (make-vector 0.35 0.9) (make-vector 0.4 1))
                           (make-segment (make-vector 0.6 1) (make-vector 0.65 0.9))
                           (make-segment (make-vector 0.65 0.9) (make-vector 0.6 0.75))
                           (make-segment (make-vector 0.6 0.75) (make-vector 0.7 0.75))
                           (make-segment (make-vector 0.7 0.75) (make-vector 1 0.4))
                           (make-segment (make-vector 1 0.2) (make-vector 0.65 0.5))
                           (make-segment (make-vector 0.65 0.5) (make-vector 0.7 0))
                           (make-segment (make-vector 0.6 0) (make-vector 0.5 0.4))
                           (make-segment (make-vector 0.5 0.4) (make-vector 0.4 0))
                           (make-segment (make-vector 0.3 0) (make-vector 0.35 0.6))
                           (make-segment (make-vector 0.35 0.6) (make-vector 0.3 0.7))
                           (make-segment (make-vector 0.3 0.7) (make-vector 0.2 0.5))
                           (make-segment (make-vector 0.2 0.5) (make-vector 0 0.75))
                           ;smile
                           (make-segment (make-vector 0.4 0.85) (make-vector 0.45 0.8))
                           (make-segment (make-vector 0.45 0.8) (make-vector 0.6 0.8))
                           (make-segment (make-vector 0.6 0.8) (make-vector 0.65 0.85))))
   
   frame))

(define (split pos1 pos2)
  (lambda (painter n)
    (if (= n 0)
        painter
        (let ((smaller ((split pos1 pos2) painter (- n 1))))
          (pos1 painter (pos2 smaller smaller))))))

(define right-split (split beside below))
(define up-split (split below beside))

(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
            (right (right-split painter (- n 1))))
        (let ((corner (corner-split painter (- n 1))))
          (beside (below painter up)
                  (below right corner))))))

(define (square-limit painter n)
  (let ((quarter (corner-split painter n)))
    (let ((half (beside quarter (flip-horiz quarter))))
      (below half (flip-vert half)))))


(paint (corner-split einstein 3))
(paint (square-limit einstein 3))

;Result:
;File 2_52_corner.jpg
;File 2_52_square.jpg
