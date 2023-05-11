#lang racket

(require test-engine/racket-tests)

;;;;;;;;;;;;;;;;;;;;; HIGHER ORDER PROCEDURES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; (all-ok? ok? xs) -> boolean?
; ok? : procedure applicable to every element of xs
; xs : list?
; returns whether ok? applied to every element of xs results in true.
; returns true if xs is empty.
(define (all-ok? ok? xs)
  (or (empty? xs)
    (and (ok? (first xs)) (all-ok? ok? (rest xs)))))

(check-expect (all-ok? positive? '()) true)
(check-expect (all-ok? positive? '(42)) true)
(check-expect (all-ok? positive? '(-42)) false)
(check-expect (all-ok? positive? '(1 2 3 4)) true)
(check-expect (all-ok? positive? '(1 -2 3 -4)) false)

; (make-proc f g) -> procedure?
; f,g : procedure, the composition f o g is well-defined
; return a composition f o g ( aka f(g(x)) )
(define (make-proc f g)
  (lambda (x) (f (g x))))

(check-expect ((make-proc positive? abs) -42) true)
(check-expect ((make-proc (λ (x) (= x 5)) length) '(1 2 3 4 5)) true)
(check-expect ((make-proc (λ (x) (= x 5)) length) '(1 2 3 4)) false)

; (my-map f xs) -> list?
; simulate the simplest version of map
(define (my-map f xs)
  (if (empty? xs) empty
    (cons (f (first xs)) (my-map f (rest xs)))))


(check-expect (my-map abs '()) '())
(check-expect (my-map positive? '(1 -2 3 -4)) '(#t #f #t #f))
(check-expect (my-map (λ (x) (+ x 42)) '(1 2 3)) '(43 44 45))

; (my-fold f id xs) -> any
; f: binary procedure
; xs: list?
; id: any
; Simulate foldr: (f x1 (f x2 (f ... (f xN id)))...)
; Apply f right-associatively to elements of xs!
(define (my-fold f id xs)
  (if (empty? xs) id
    (f (first xs) (my-fold f id (rest xs)))
  )
)

(check-expect (my-fold * 1 '(1 2 3))
              6)
(check-within (my-fold max -inf.0 '(9 20 5 6 78 100 10000))
              10000.0
              0.01)
(check-expect (my-fold cons '() '(1 2 3)) '(1 2 3))
(check-expect (my-fold list '() '(1 2 3)) '(1 (2 (3 ()))))

; (append-two xs ys)
; simulate (append xs ys) using a single call to foldr
; (no recursion!)
(define (append-two xs ys)
  (foldr cons ys xs))

(check-expect (append-two '() '()) '())
(check-expect (append-two '(1) '()) '(1))
(check-expect (append-two '(1) '(2)) '(1 2))
(check-expect (append-two '(1 2 3) '(4 5)) '(1 2 3 4 5))

; (append-lists lists)
; return the result of appending all sublists in lists
; - takes a list of 0 or more arguments
(define (append-lists lists)
  (if (empty? lists) empty
    (foldr append-two '() lists)
  )
)

(check-expect (append-lists '())
              '())
(check-expect (append-lists '((1 2 3)))
              '(1 2 3))
(check-expect (append-lists '((1 2) (3 4) (5 6)))
              '(1 2 3 4 5 6))

; (my-map-nonrec f xs)
; simuate (map f xs) using a sinlge call to foldr
(define (my-map-nonrec f xs)
  (if (empty? xs) empty
    (foldr (lambda(x y) (cons (f x) y)) '() xs) 
  )
)

(check-expect (my-map-nonrec abs '()) '())
(check-expect (my-map-nonrec positive? '(1 -2 3 -4)) '(#t #f #t #f))
(check-expect (my-map-nonrec (λ (x) (+ x 42)) '(1 2 3)) '(43 44 45))


; variable arguments
(define variable-args
  (lambda args (apply + args))
)

(check-expect (variable-args 1 2 3) 6)
(check-expect (variable-args 0) 0)

(test)