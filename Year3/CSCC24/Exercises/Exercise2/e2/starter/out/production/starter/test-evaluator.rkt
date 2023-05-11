#lang racket

(require rackunit)
(require rackunit/text-ui)
(require "evaluator.rkt")

(define-test-suite evaluator-test-suite
  
  (test-equal? 
   "evaluate"
   (evaluate '(a and (b or c))
             '((a . #t) (b . #f) (c . #t)))
   #t)

  (test-equal? 
   "evaluate"
   (evaluate '((a and (not b)) or ((a and c) or ((not b) and c)))
             '((a . #t) (b . #f) (c . #f) (d . #t)))
   #t)

  (test-equal? 
   "evaluate"
   (evaluate '(((a)))
             '((a . #t)))
   #t)
  
   (test-equal? 
   "evaluate single T"
   (evaluate #t empty)
   #t)

  (test-equal? 
   "evaluate single var"
   (evaluate 'a '((a . #t)))
   #t)

  (test-equal? 
   "evaluat bracket var"
   (evaluate '(((a)))
             '((a . #t)))
   #t)

  (test-equal? 
   "evaluate single var F"
   (evaluate 'abc '((abc . #f)))
   #f)

  (test-equal? 
   "evaluate single NOT T"
   (evaluate '(not a) '((a . #t)))
   #f)

  (test-equal? 
   "evaluate single NOT F"
   (evaluate '(not a) '((a . #f)))
   #t)

  (test-equal? 
   "evaluate single NOT F bracketed"
   (evaluate '(((((not a))))) '((a . #f)))
   #t)
  
  (test-equal? 
   "evaluate ex1"
   (evaluate '(a and (b or c))
             '((a . #t) (b . #f) (c . #t)))
   #t)

  (test-equal? 
   "evaluate ex2"
   (evaluate '((a and (not b)) or ((a and c) or ((not b) and c)))
             '((a . #t) (b . #f) (c . #f) (d . #t)))
   #t)

  (test-equal? 
   "evaluate ex3"
   (evaluate '((a and b) or c)
             '((a . #t) (b . #f) (c . #f)))
   #f)

  (test-equal? 
   "evaluate ex4"
   (evaluate '((a implies b) or c)
             '((a . #t) (b . #f) (c . #f)))
   #f)

  (test-equal? 
   "evaluate ex5"
   (evaluate '((a implies b) or c)
             '((a . #f) (b . #f) (c . #f)))
   #t)
  )

(define-test-suite simplifier-test-suite
  
  (test-equal? 
   "simplify"
   (simplify '(a and (b or c))
             '((a . #t) (b . #f) (c . #t)))
   #t)

  (test-equal? 
   "simplify"
   (simplify '(a and (b or c))
             '((b . #f) (c . #t)))
   'a)

  (test-equal? 
   "simplify"
   (simplify '((a and (not b)) or ((a and c) or ((not b) and c)))
             '((a . #t) (c . #f) (d . #t)))
   '(not b))

  (test-equal? 
   "simplify"
   (simplify '(((a)))
             '())
   'a)
  )

(display (run-tests evaluator-test-suite))
(display (run-tests simplifier-test-suite))