#! /usr/bin/racket
#lang racket


;Using Data directed programming, each division's personnel file can be attached a type specific to that division. Furthermore, procedures specific to getting a record can be stored in a 2-D table.
;a

(define (get-record employee-name personnel-file)
  (get employee-name (type personnel-file)))

;Individual division's file could follow any structure they please as long as the record is attached a type.
;E.g. Division 1's record could be of the form (cons salary address), plus a type of division-1 attached to it.
;E.g. (cons 'division-1 (cons salary address))

;b

(define (get-salary employee-record)
  (get (type employee-record) 'salary))

;In this case the record can be of the form '(cons 'division-x (make-record-division1 salary address))
;And the salary selector can be put in the table like:


(define (select-salary record)
  (car record))

(put 'salary 'division-x select-salary)


;c

(define (find-employee-record employee-name all-division-files)
  (get all-division-files employee-name))

;This will return a record of the form '(cons type datum)

;d
When a new company merges into the system, all that needs to be done is create new entries into the table for x dimensions of salary and address and y dimension of new division name. This will return a selector specific to that type of record.


