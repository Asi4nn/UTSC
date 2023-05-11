#lang racket

(require test-engine/racket-tests)

(provide my-length length-tail my-reverse reverse-tail
         num-els num-els-hop num-els-tail
         sum-els sum-els-hop sum-els-tail
         flatten flatten-hop flatten-tail)

; (my-length xs) -> integer?
; xs: list?
; returns the number of elements in xs
(define (my-length xs)  ; return length[xs]
  (if (empty? xs)
      0
      (+ 1 (my-length (rest xs)))))

(check-expect (my-length '()) 0)
(check-expect (my-length '(42)) 1)
(check-expect (my-length '(1 2 (3 6) 4 5)) 5)

; [my-length '[1 2]]
; [+ 1 [my-length '[2]]]
; ...

; (length-tail xs) -> integer?
; xs: list?
; returns the number of elements in xs
; a tail-recursive version
(define (length-tail xs)  ; return length[xs]
  (local [(define (len-t xs acc)  ; return length[xs] + acc
            (if (empty? xs)
                acc
                (len-t (rest xs) (+ acc 1))))]
    (len-t xs 0)))

(check-expect (length-tail '()) 0)
(check-expect (length-tail '(42)) 1)
(check-expect (length-tail '(1 2 (3 6) 4 5)) 5)

; [len-t '[1 2] 0]
; ...

; (my-reverse xs) -> list?
; xs: list?
; returns the reverse of xs
(define (my-reverse xs)  ; return reverse[xs]
  (if (empty? xs)
      '()
      (append (my-reverse (rest xs)) (list (first xs)))))

(check-expect (my-reverse '()) '())
(check-expect (my-reverse '(42)) '(42))
(check-expect (my-reverse '(1 2 3)) '(3 2 1))

; What is the time complexity of my-reverse?
; What is the space complexity of my-reverse?

; (reverse-tail xs) -> list?
; xs: list?
; returns the reverse of xs
; a tail recursive version
(define (reverse-tail xs)        ; return reverse[xs]
  (local [(define (rev-t xs acc)
            (if (empty? xs)
                acc
                (rev-t (rest xs) (append (list (first xs)) acc))))]
    (rev-t xs '())))

(check-expect (reverse-tail '()) '())
(check-expect (reverse-tail '(42)) '(42))
(check-expect (reverse-tail '(1 2 3)) '(3 2 1))

; What is the time complexity of reverse-tail?
; What is the space complexity of reverse-tail?

; (num-els xs) -> integer?
; xs: list?
; Returns the number of elements in xs, including any sublists, on any nesting level.
; Recursive. Not tail-recursive.
(define (num-els xs)
  (cond [(empty? xs) 0]
        [(list? (first xs))
         (+ (num-els (first xs)) (num-els (rest xs)))]
        [else (+ 1 (num-els (rest xs)))]))

(check-expect (num-els '(1 (2 (3 4 ((((5))) 6) 7)) 8)) 8)

; using HOPs, higher order procedures, (and recursion)
(define (num-els-hop xs)
  (foldr (lambda (x y) (if (list? x) (+ (num-els-hop x) y) (+ 1 y))) 0 xs))

(check-expect (num-els-hop '(1 (2 (3 4 ((((5))) 6) 7)) 8)) 8)

; tail-recursive version
(define (num-els-tail xs)
  (local [(define (ne-t xs acc)
            (cond [(empty? xs) acc]
                  [(list? (first xs)) (ne-t (append (first xs) (rest xs)) acc)]
                  [else (ne-t (rest xs) (+ acc 1))]))]
    (ne-t xs 0)))

(check-expect (num-els-tail '(1 (2 (3 4 ((((5))) 6) 7)) 8)) 8)

; (sum-els xs) -> number?
; xs: list of number?
; Returns the sum of elements in xs, including any sublists, on any nesting level.
; Returns 0 if xs is empty.
; Recursive. Not tail-recursive.
(define (sum-els xs)
  (cond [(empty? xs) 0]
        [(list? (first xs))
         (+ (sum-els (first xs)) (sum-els (rest xs)))]
        [else (+ (first xs) (sum-els (rest xs)))]))

(check-expect (sum-els '(1 (2 (3 4 ((((5))) 6) 7)) 8)) 36)

; using HOPs (and recursion)
(define (sum-els-hop xs)
  (foldr (lambda (x y) (if (list? x) (+ (sum-els-hop x) y) (+ x y))) 0 xs))

(check-expect (sum-els-hop '(1 (2 (3 4 ((((5))) 6) 7)) 8)) 36)
(check-expect (sum-els-hop '(((((((())))))))) 0)

; tail-recursive version
(define (sum-els-tail xs)
  (local [(define (se-t xs acc)
            (cond [(empty? xs) acc]
                  [(list? (first xs)) (se-t (append (first xs) (rest xs)) acc)]
                  [else (se-t (rest xs) (+ acc (first xs)))]))]
    (se-t xs 0)))

(check-expect (sum-els-tail '(1 (2 (3 4 ((((5))) 6) 7)) 8)) 36)
(check-expect (sum-els-tail '(((((((())))))))) 0)

; (flatten xs) -> list?
; xs: list?
; Returns the flattened version of xs.
; Recursive. Not tail-recursive.
(define (flatten xs)
  (cond [(empty? xs) xs]
        [(list? (first xs)) (append (flatten (first xs)) (flatten (rest xs)))]
        [else (cons (first xs) (flatten (rest xs)))]))

; (if (empty? xs)
;     '()
;     (append (if (list? (first xs))
;               (flatten-hop (first xs))
;               (list (first xs)))
;           (flatten-hop (rest xs)))))

(check-expect (flatten '(1 (2 (3 4 ((((5))) 6) 7)) 8))
              '(1 2 3 4 5 6 7 8))

; using HOPs (and recursion)
(define (flatten-hop xs)
  (foldr (lambda (x y) (if (list? x) (append (flatten-hop x) y) (cons x y))) '() xs))

(check-expect (flatten-hop '(1 (2 (3 4 ((((5))) 6) 7)) 8))
              '(1 2 3 4 5 6 7 8))

; tail-recursive version
(define (flatten-tail xs)
  (local [(define (f-t xs acc)
            (cond [(empty? xs) acc]
                  [(list? (first xs)) (f-t (rest xs) (f-t (first xs) acc))]
                  [else (f-t (rest xs) (cons (first xs) acc))]))]
    (reverse (f-t xs '()))))

(check-expect (flatten-tail '(1 (2 (3 4 ((((5))) 6) 7)) 8))
              '(1 2 3 4 5 6 7 8))

(module+ main
   (test)
)