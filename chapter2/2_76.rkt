#! /usr/bin/racket
#lang racket

;1. For generic operations with explicit dispatch, for each new data type, each generic operation needs to add a new condition to check for the type.
;For each new generic operation, there needs to be a new procedure that covers all existing data types.

;2. For data-directed style, every new operation creates a new row, and every new type creates a new column

;3. For message-passing style, every new operation would mean a new condition in internal dispatch of the data object. Every new type means a new dispatching system.

;In a system where new types are often added, I think data-directed style makes more sense. Same for new operations often being added.
