;All symbols are denoted as a1, a2 .., an.
;For n=5
;Frequencies are '((a1 1) (a2 2) (a3 4) (a4 8) (a5 16))
;Corresponding Tree:

;      .(31)
;     / \
;   a5   .(15)
;  (16) / \
;     a4   .(7)
;    (8)  / \
;       a3   .(3)
;      (4)  / \
;         a2   a1
;        (2)   (1)

;Similarly, for n=10, the tree will be balanced at every node by the symbol ak for all symbols (a1, a2 .., ak-1)
;For the most frequent symbol, which will be an, number of bits needed to encode will be 1.
;For the least frequent symbol a1, the number of bits required to encode will be n-1.
