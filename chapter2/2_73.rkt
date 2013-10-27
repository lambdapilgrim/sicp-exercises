(define (deriv exp var)
   (cond ((number? exp) 0)
         ((variable? exp) (if (same-variable? exp var) 1 0))
         (else ((get 'deriv (operator exp)) (operands exp)
                                            var))))

(define (operator exp) (car exp))
(define (operands exp) (cdr exp))


;a. Instead of having a conditional predicate dictate the rules of derivative for each type of expression, we made use of data directed programming to get the definition of derivative function for that type of expression. We can't assimilate the predicates because the function that will be looked up from the table is supposed to work on complex expressions that have operands. number and variable expressions are unary expressions.

;b. 

(define (sum-deriv exp var)
    (make-sum (deriv (addend exp) var)
    	      (deriv (augend exp) var)))

(define (prod-deriv exp var)
    (make-sum
	(make-product (multiplier exp)
		      (deriv (multiplicand exp) var))
        (make-product (deriv (multiplier exp) var)
		      (multiplicand exp))))

(put 'deriv '(+) sum-deriv)
(put 'deriv '(*) prod_deriv)

;c.

(define (exp-deriv exp var)
     (let ((b (base exp)) (e (exponent exp)))
          (make-product e (make-product (make-exponentiation b (- e 1)) (deriv b var)))))

(put 'deriv '(**) exp-deriv)

;d.

The only changes necessary would be to put the definition of derivative functions in the right cell identified by two indices. E.g. instead of:

(put 'deriv '(**) exp-deriv)

it will be

(put '(**) 'deriv exp-deriv)

