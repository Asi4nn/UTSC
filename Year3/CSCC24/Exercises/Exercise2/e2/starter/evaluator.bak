#lang racket

(provide evaluate simplify)

(define unary-op first)
(define operand second)
(define binary-op second)
(define left first)
(define right third)
(define (variable? v) (not (or (boolean? v) (list? v))))
(define (unary? expr) (and (list? expr) (= 2 (length expr))))
(define (binary? expr) (and (list? expr) (= 3 (length expr))))
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
        (cons 'not not)
        (cons 'implies (λ (a b) (or (not a) b)))
        ))

; helper op lookup procedure
(define (op-lookup op)
  (value-of op ops))

; simplifiers
(define (and-simplifier l r)
  (cond
    [(and (boolean? l) (boolean? r)) (and l r)]
    [(and (boolean? l) (and l #t)) r]
    [(and (boolean? r) (and r #t)) l]
    [(and (boolean? l) (nor l #f)) #f]
    [(and (boolean? r) (nor r #f)) #f]
    [else (cons l 'and r)]))

(define (or-simplifier l r)
  (cond
    [(and (boolean? l) (boolean? r)) (or l r)]
    [(and (boolean? l) (and l #t)) #t]
    [(and (boolean? r) (and r #t)) #t]
    [(and (boolean? l) (nor l #f)) r]
    [(and (boolean? r) (nor r #f)) l]
    [else (cons l 'or r)]))

(define (not-simplifier op)
  (cond
    [(boolean? op) (not op)]
    [(and (unary? op) (= (unary-op op) 'not)) (operand op)]
    [else (cons 'not (cons op '()))]))

(define (implies-simplifier l r)
  (cond
    [(and l #t) r]
    [(and r #t) #t]
    [(nor l #f) #t]
    [(nor r #f) '(not l)]
    [else (cons l 'implies r)]))

(define simplifiers
  (list (cons 'and and-simplifier)
        (cons 'or or-simplifier)
        (cons 'not not-simplifier)
        (cons 'implies implies-simplifier)
        ))

; (evaluate expr context) -> boolean?
; expr: a valid representation of an expression
; context: list of pairs of the form (variable . #t/#f)
; Return the value of expr under the truth assignment context.
; Pre: every variable that appears in expr also appears in context.
(define (evaluate expr context)
  (cond
    [(bracketed? expr) (evaluate (first expr) context)]
    [(binary? expr) ((op-lookup (binary-op expr)) (evaluate (left expr) context) (evaluate (right expr) context))]
    [(unary? expr) ((op-lookup (unary-op expr)) (evaluate (operand expr) context))]
    [(variable? expr) (value-of expr context)]
    [else expr]))


; (simplify expr context) -> valid expression
; expr: a valid representation of an expression
; context: list of pairs of the form (variable . #t/#f)
; Return an expression that is equivalent to expr,
; but is simplified as much as possible, according to
; the given rules.
(define (simplify expr context)
  (cond
    [(bracketed? expr) (simplify (first expr) context)]
    [(binary? expr) ((value-of (binary-op expr) simplifiers) (simplify (left expr) context) (simplify (right expr) context))]
    [(unary? expr) ((value-of (unary-op expr) simplifiers) (simplify (operand expr) context))]
    [(variable? expr) (value-of expr context)]))
