#lang racket

(require rackunit)
(require rackunit/text-ui)
(require "prop.rkt")

(define-test-suite formula-test-suite
  (test-equal? 
   "formula"
   (formula '(x))
   #t)

  (test-equal? 
   "formula"
   (formula '(x y))
   #f)

  (test-equal? 
   "formula"
   (formula '(a implies (b and (neg #f))))
   #t)
)

(define-test-suite sub-test-suite
  (test-equal? 
   "sub"
   (sub '(x)
    '((x . #t)))
   '(#t))

  (test-equal? 
   "sub"
   (sub '(a implies (b and (neg #f)))
    '((a . #t) (b . #f)))
   '(#t implies (#f and (neg #f))))
)

(define-test-suite eval-test-suite
  
  (test-equal? 
   "eval"
   (eval '(a and (b or c))
             '((a . #t) (b . #f) (c . #t)))
   #t)

  (test-equal? 
   "eval"
   (eval '((a and (neg b)) or ((a and c) or ((neg b) and c)))
             '((a . #t) (b . #f) (c . #f) (d . #t)))
   #t)
  )

(display (run-tests formula-test-suite))
(display (run-tests sub-test-suite))
(display (run-tests eval-test-suite))