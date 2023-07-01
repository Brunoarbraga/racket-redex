#lang racket
(require redex)

#| Syntax |#
(define-language ArithL
  (v ::= false true)
  (b ::= v (and b b) (or b b)))


#| Semantics |#
(define-extended-language
  
  ArithCtx
  ArithL
  (E ::= hole (and v E) (and E b) (or v E) (or E b)))

(define ->b
  (reduction-relation
   ArithCtx
   #:domain b
   
   (--> (in-hole E (and b true)) (in-hole E b) "E-and-true")
   (--> (in-hole E (and b false)) (in-hole E false) "E-and-false")
   
   (--> (in-hole E (or b true)) (in-hole E true) "E-or-true")
   (--> (in-hole E (or b false)) (in-hole E b) "E-or-false")))

(traces ->b (term (and (and true false) False)))


