#lang racket

(require test-engine/racket-tests)


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
    (f (first xs) (my-fold f id (rest xs)))))

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
  (if (empty? lists)
    empty
    (foldr append-two '() lists)))

(check-expect (append-lists '())
              '())
(check-expect (append-lists '((1 2 3)))
              '(1 2 3))
(check-expect (append-lists '((1 2) (3 4) (5 6)))
              '(1 2 3 4 5 6))

; (my-map-nonrec f xs)
; simuate (map f xs) using a sinlge call to foldr
(define (my-map-nonrec f xs)
  (if (empty? xs)
    empty
    (foldr (lambda(x y) (cons (f x) y)) '() xs)))

(check-expect (my-map-nonrec abs '()) '())
(check-expect (my-map-nonrec positive? '(1 -2 3 -4)) '(#t #f #t #f))
(check-expect (my-map-nonrec (λ (x) (+ x 42)) '(1 2 3)) '(43 44 45))


; (my-append list1 list2 ...) simulate append
; - takes 0 or more arguments
(define my-append
  (lambda lists
    (foldr append-two empty lists)))

(check-expect (my-append ) '())
(check-expect (my-append '(1 2 3))
              '(1 2 3))
(check-expect (my-append '(1 2) '(3 4) '(5 6))
              '(1 2 3 4 5 6))

; (make-inc x) -> procedure?
; x: number?
; returns a function that takes a number n and returns x + n
(define (make-inc x)
  (lambda (y) (+ x y)))

;(define inc-by-5 (make-inc 5))
;(inc-by-5 100)

;(define inc-by-10 (make-inc 10))
;(inc-by-10 100)

;(define (plus-x y)
;  (+ x y))

(define x 100)
(define (plus-x y)
  (+ x y))

;(plus-x 10)

;(let ([x 200])
;  (plus-x 10))

;(set! x 200)
;(plus-x 10)


(define counter
  (let ([count 0])
    (lambda ()
      (set! count (+ count 1))
      count)))

;(counter)
;(counter)
;(counter)

(define make-counter
  (let ([global-count 0])
    (lambda ()
      (let ([local-count 0])
        (lambda ()
          (set! global-count (+ global-count 1))
          (set! local-count (+ local-count 1))
          (cons global-count local-count))))))

(define counter1 (make-counter))
(define counter2 (make-counter))

;(counter1)
;(counter1)
;(counter2)
;(counter2)
;(counter1)


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
; 1 + [my-length '[2]]

; (length-tail xs) -> integer?
; xs: list?
; returns the number of elements in xs
; a tail-recursive version
(define (length-tail xs)  ; return length[xs]
  (local
    [(define (len-t xs len)  ; return ???
       (if (empty? xs)
       len
       (len-t (rest xs) (+ len 1))))]
    (len-t xs 0)))

(check-expect (length-tail '()) 0)
(check-expect (length-tail '(42)) 1)
(check-expect (length-tail '(1 2 (3 6) 4 5)) 5)

; [len-t '[1 2] 0]

; (my-reverse xs) -> list?
; xs: list?
; returns the reverse of xs
(define (my-reverse xs)  ; return reverse[xs]
  (if (empty? xs)
      empty
      (append (my-reverse (rest xs)) (list (first xs)))))
  
(check-expect (my-reverse '()) '())
(check-expect (my-reverse '(42)) '(42))
(check-expect (my-reverse '(1 2 3)) '(3 2 1))

; (reverse-tail xs) -> list?
; xs: list?
; returns the reverse of xs
; a tail recursive version
(define (reverse-tail xs)        ; return reverse[xs]
  (local
    [(define (reverse-t xs acc)  ; return ??
       (if (empty? xs)
           acc
           (reverse-t (rest xs) (cons (first xs) acc))))]
    (reverse-t xs '())))

(check-expect (reverse-tail '()) '())
(check-expect (reverse-tail '(42)) '(42))
(check-expect (reverse-tail '(1 2 3)) '(3 2 1))


(define (my-length-cps xs)   ; return length[xs]
  (local
    [(define (len-cps xs k)  ; return ??
       42)]
    (len-cps 42 42)))

(check-expect (my-length-cps '()) 0)
(check-expect (my-length-cps '(42)) 1)
(check-expect (my-length-cps '(1 2 (3 6) 4 5)) 5)


; Let's write a tail recursive version of foldr.
(define (foldr-tail-first-try f id xs)
  (local
    [(define (foldr-tail xs acc)
       (if (empty? xs)
           acc
           (foldr-tail (rest xs) (f (first xs) acc))))]
    (foldr-tail xs id)))

(check-expect (foldr-tail-first-try * 1 '(1 2 3))
              6)
(check-within (foldr-tail-first-try max -inf.0 '(9 20 5 6 78 100 10000))
              10000.0
              0.01)
;(check-expect (foldr-tail-first-try cons '() '(1 2 3)) '(1 2 3))
;(check-expect (foldr-tail-first-try list '() '(1 2 3)) '(1 (2 (3 ()))))


(define (foldr-tail f id xs)  ; returns [foldr f id xs]
  (local
    [(define (foldr-cps xs k)  ; returns ???
       42)]
    (foldr-cps 42 42)))

(check-expect (foldr-tail * 1 '(1 2 3))
              6)
(check-within (foldr-tail max -inf.0 '(9 20 5 6 78 100 10000))
              10000.0
              0.01)
(check-expect (foldr-tail cons '() '(1 2 3)) '(1 2 3))
(check-expect (foldr-tail list '() '(1 2 3)) '(1 (2 (3 ()))))

(test)