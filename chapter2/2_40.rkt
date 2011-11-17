#! /usr/bin/env racket
#lang racket

(define (prime? n)
  (define (fast-prime? n times)
    (define (fermat-test n)
      (define (try-it a)
        (define (expmod base exp m)
          (define (square x)
            (* x x))          
          (cond ((= exp 0) 1)
                ((even? exp)
                 (remainder (square (expmod base (/ exp 2) m))
                            m))
                (else
                 (remainder (* base (expmod base (- exp 1) m))
                            m))))
        (= (expmod a n n) a))
      (try-it (+ 1 (random (- n 1)))))
    (cond ((= times 0) true)
          ((fermat-test n) (fast-prime? n (- times 1)))
          (else false)))
  (fast-prime? n 10))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

(define (enumerate-interval m n)
  (if (> m n)
      '()
      (cons m (enumerate-interval (+ m 1) n))))

(define (unique-pairs n)
  (flatmap
   (lambda (i)
     (map (lambda (j) (list i j))
          (enumerate-interval 1 (- i 1))))
   (enumerate-interval 1 n)))

(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum? (unique-pairs n))))

(prime-sum-pairs 10)


;'((2 1 3)  (3 2 5)  (4 1 5)  (4 3 7)  (5 2 7)  (6 1 7)  (6 5 11)  (7 4 11)  (7 6 13)  (8 3 11)  (8 5 13)  (9 2 11)  (9 4 13)  (9 8 17)  (10 1 11)  (10 3 13)  (10 7 17)  (10 9 19))
