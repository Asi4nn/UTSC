#lang racket

(require test-engine/racket-tests)

; Part 2
(define (replace x y xs)
  (if (empty? xs) empty
    (if (= (first xs) x)
      (cons y (replace x y (rest xs)))
      (cons (first xs) (replace x y (rest xs))))))

; Part 4
(define my-or
  (lambda (a b)
    (or a b)))

(check-expect (or #f) #f)
(check-expect (my-or #t) #t)

(test)