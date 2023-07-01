#lang racket
(require redex)

#| Syntax |#
(define-language ArithL
  (v ::= natural)
  (e ::= v (+ e e) (- e e) (* e e) (/ e e)))


#| Semantics |#
(define-extended-language
  
  ArithCtx
  ArithL
  (E ::= hole (+ v E) (+ E e)
              (- v E) (- E e)
              (* v E) (* E e)
              (/ v E) (/ E e)))
              

(define ->e
  (reduction-relation
   ArithCtx
   #:domain e
   
   (-->e (+ v_1 v_2) ,(+ (term v_1) (term v_2)) "E-add")
   (-->e (- v_1 v_2) ,(- (term v_1) (term v_2)) "E-sub")
   (-->e (* v_1 v_2) ,(* (term v_1) (term v_2)) "E-mul")
   (-->e (/ v_1 v_2) ,(/ (term v_1) (term v_2)) "E-div")

   with
     [(--> (in-hole E a) (in-hole E b))
      (-->e a b)]))

(traces ->e (term (+ 2 3)))


