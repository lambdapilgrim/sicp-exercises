#! /usr/bin/env racket
#lang racket

(define (make-vect xcor ycor)
  (cons xcor ycor))

(define (xcor-vect vect)
  (car vect))

(define (ycor-vect vect)
  (cdr vect))

(define (add-vect vect1 vect2)
  (make-vect
   (+ (xcor-vect vect1) (xcor-vect vect2))
   (+ (ycor-vect vect1) (ycor-vect vect2))))

(define (sub-vect vect1 vect2)
  (make-vect
   (- (xcor-vect vect1) (xcor-vect vect2))
   (- (ycor-vect vect1) (ycor-vect vect2))))

(define (scale-vect factor vect)
  (make-vect
   (* (xcor-vect vect) factor)
   (* (ycor-vect vect) factor)))

(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame frame)
  (car frame))

(define (edge1-frame frame)
  (car (cdr frame)))

(define (edge2-frame frame)
  (car (cdr (cdr frame))))

(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v)
                           (edge1-frame frame))
               (scale-vect (ycor-vect v)
                           (edge2-frame frame))))))

(define (transform-painter painter origin corner1 corner2)
  (lambda (frame)
    (let ((m (frame-coord-map frame)))
      (let ((new-origin (m origin)))
        (painter
         (make-frame new-origin
                     (sub-vect (m corner1) new-origin)
                     (sub-vect (m corner2) new-origin)))))))

(define (flip-horiz painter)
  (transform-painter painter
                     (make-vect 1.0 0.0)
                     (make-vect 0.0 0.0)
                     (make-vect 1.0 1.0)))

(define (rotate180 painter)
  (transform-painter painter
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 1.0)
                     (make-vect 1.0 0.0)))

(define (rotate270 painter)
  (transform-painter painter
                     (make-vect 0.0 1.0)
                     (make-vect 0.0 0.0)
                     (make-vect 1.0 1.0)))

;A definition for painter for testing. It prints origin, edge1 and edge2
;vectors of the frame

(define (test-painter frame)
  (newline)
  (display "origin ")(display (origin-frame frame))
  (newline)
  (display "edge1 ")(display (edge1-frame frame))
  (newline)
  (display "edge2 ")(display (edge2-frame frame))
  (newline))

(define test-frame (make-frame
                    (make-vect 5.0 4.0)
                    (make-vect 1.0 -1.0)
                    (make-vect 1.0 1.0)))

((flip-horiz test-painter) test-frame)
((rotate180 test-painter) test-frame)
((rotate270 test-painter) test-frame)

;origin (6.0 . 3.0)
;edge1 (-1.0 . 1.0)
;edge2 (1.0 . 1.0)

;origin (7.0 . 4.0)
;edge1 (-1.0 . 1.0)
;edge2 (-1.0 . -1.0)

;origin (6.0 . 5.0)
;edge1 (-1.0 . -1.0)
;edge2 (1.0 . -1.0)

