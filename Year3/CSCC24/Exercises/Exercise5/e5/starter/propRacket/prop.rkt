#lang racket

(provide formula sub eval)

; Much of this implementation is from e2

(define unary-op first)
(define operand second)
(define binary-op second)
(define left first)
(define right third)
(define (literal? expr) (boolean? expr))
(define (variable? v) (not (or (boolean? v) (list? v))))
(define (unary? expr) (and (list? expr) (= 2 (length expr)) (procedure? (op-lookup (unary-op expr)))))
(define (binary? expr) (and (list? expr) (= 3 (length expr)) (procedure? (op-lookup (binary-op expr)))))
(define (bracketed? expr) (and (list? expr) (= 1 (length expr))))

; (value-of k values) -> any
; k: any
; values: list of key/value pairs
; If k is a key in values, then return the value for that key.
; Otherwise, return k itself.
(define (value-of k values)
  (dict-ref values k k))

(define ops
  (list (cons 'and (λ (a b) (and a b)))
        (cons 'or (λ (a b) (or a b)))
        (cons 'neg not)
        (cons 'implies (λ (a b) (or (not a) b)))
        ))

; helper op lookup procedure
(define (op-lookup op)
  (value-of op ops))

; (formula f) -> boolean?
; f: a boolean formula
; Return if f is a valid formula according to question 2
(define (formula f)
  (cond
    [(bracketed? f) (formula (first f))]
    [(binary? f) (and (formula (left f)) (formula (right f)))]
    [(unary? f) (formula (operand f))]
    [(or (literal? f) (variable? f)) #t]
    [else #f]))

; (sub f asst) -> any
; f: a valid formula
; asst: truth assignment of variables
; Return the formula f with the substitution asst
; Pre: formula f is a valid formula
(define (sub f asst)
  (cond
    [(bracketed? f) (cons (sub (first f) asst) '())]
    [(binary? f) (list (sub (left f) asst) (binary-op f) (sub (right f) asst))]
    [(unary? f) (list (unary-op f) (sub (operand f) asst))]
    [(variable? f) (value-of f asst)]
    [else f]))

; (eval expr context) -> boolean?
; expr: a valid representation of an expression
; context: list of pairs of the form (variable . #t/#f)
; Return the value of expr under the truth assignment context.
; Pre: every variable that appears in expr also appears in context.
(define (eval expr context)
  (cond
    [(bracketed? expr) (eval (first expr) context)]
    [(binary? expr) ((op-lookup (binary-op expr)) (eval (left expr) context) (eval (right expr) context))]
    [(unary? expr) ((op-lookup (unary-op expr)) (eval (operand expr) context))]
    [(variable? expr) (value-of expr context)]
    [else expr]))
