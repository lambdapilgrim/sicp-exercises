;For the encode-symbol procedure I wrote in 2.68:

(define (encode-symbol symbol tree)
  (define (encode-symbol-aux tree enc-string)
    (cond ((not (element-of? symbol (symbols tree))) (error "symbol not in tree -- ENCODE-SYMBOL" symbol))
          ((leaf? tree) enc-string)
          (else 
           (cond ((element-of? symbol (symbols (left-branch tree))) (encode-symbol-aux (left-branch tree) (append enc-string (list 0))))
                 (else (encode-symbol-aux (right-branch tree) (append enc-string (list 1))))))))
  (encode-symbol-aux tree '()))

;at each node, first the presence of symbol is checked, which may take O(n) time, where n is the total number of symbols
;at that node. Later, the presence of symbol in one of the child nodes is determined in another O(n) time. This takes place
;for the height of the tree. For a balanced tree, this will be lg(n) steps. So, in general order of growth will be O(n.lgn).

;For the special case of frequencies as given in 2.70, the least frequent symbol will take O(n. n) time, whereas the most
;frequent symbol will take O(n) time.
