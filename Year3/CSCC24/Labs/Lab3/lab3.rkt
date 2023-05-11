#lang racket

(require test-engine/racket-tests)

(provide vector-add-rec vector-add-map dot-product-rec dot-product-map scalar-vector-mult
         scalar-mult transpose-rec transpose-map add mult)

; Learning objective: practice using recursion, map and apply in Racket.
; Of course, if our task was to in fact do matrix manipulation, we would choose a more appropriate
; language, such as matlab. Here our goal is to get a lot of practice using higher order procedures.

; Throughout this module we represent a vector by a list and a matrix by a list of lists of numbers.
; You may assume all list sizes are such that we have well-defined matrices and matrix operations.
; An empty matrix is the empty list '().

(define m1 '((1 0 2)
             (2 1 4)
             (-1 1 -1)))
(define m2 '((1 2 3)
             (4 5 6)
             (7 8 9)))
(define m3 '((2 2 5)
             (6 6 10)
             (6 9 8)))
(define m1tr '((1 2 -1)
               (0 1 1)
               (2 4 -1)))

;; (vector-add-rec v1 v2) -> list?
;; v1, v2: list of numbers of the same size
;; return v1 + v2
;; a simple recursive version
(define (vector-add-rec v1 v2)
  (if (empty? v1) empty
    (cons (+ (first v1) (first v2)) (vector-add-rec (rest v1) (rest v2)))
  )
)

(check-expect (vector-add-rec '(1 2 3) '(-1 3 -2)) '(0 5 1))

; no recursion! suggestion: use map
(define (vector-add-map v1 v2)
  (if (empty? v1) empty
    (map (lambda (x1 x2) (+ x1 x2)) v1 v2)
  )
)

(check-expect (vector-add-map '(1 2 3) '(-1 3 -2)) '(0 5 1))

;; (dot-product v1 v2) -> number?
;; v1, v2: list of numbers of the same size
;; returns the dot product of v1 and v2
;; a simple recursive version
(define (dot-product-rec v1 v2)
  (if (empty? v1) 0 
    (+ (* (first v1) (first v2)) (dot-product-rec (rest v1) (rest v2)))
  )  
)

(check-expect (dot-product-rec '(1 2 3) '(-1 3 -2)) -1)

; no recursion! suggestion: use map and apply
(define (dot-product-map v1 v2)
  (if (empty? v1) 0 
    (apply + (map (lambda (x1 x2) (* x1 x2)) v1 v2))
  )
)

(check-expect (dot-product-map '(1 2 3) '(-1 3 -2)) -1)

;; (add m1 m2) -> list?
;; m1, m2: list of list of numbers of same dimensions
;; return m1 + m2 for matrices m1, m2
;; no recursion! suggestion: use map
(define (add m1 m2)
  (if (empty? m1) empty
    (map (lambda (l1 l2) (map (lambda (x1 x2) (+ x1 x2)) l1 l2)) m1 m2)
  )
)

(check-expect (add m1 m2) m3)

;; (scalar-vector-mult k v) -> list?
;; k: number?
;; v: list of number
;; return the scalar multiplication kv
;; no recursion! suggestion: use map
(define (scalar-vector-mult k v)
  (if (empty? v) empty
    (map (lambda (x) (* k x)) v)
  )  
)

(check-expect (scalar-vector-mult 2 '(-1 3 -2)) '(-2 6 -4))

;; (scalar-mult k m) -> list?
;; k: number
;; m: list of list of number
;; return the scalar multiplication km
;; no recursion! suggestion: use map
(define (scalar-mult k m)
  (if (empty? m) empty
    (map (lambda (y) (map (lambda (x) (* k x)) y)) m)
  )
)

(check-expect (scalar-mult 2 m1)
              '((2 0 4)
                (4 2 8)
                (-2 2 -2)))


;; (transpose m) -> list?
;; m: list of list of number, non-empty
;; return the transpose of matrix m
;; a recursive version (using map as part of the recursive case is OK!)
(define (transpose-rec m)
  (if (or (empty? m) (empty? (first m))) '()
    (cons (map first m) (if (empty? (rest m)) empty (transpose-rec (map rest m))))
  )
)

(check-expect (transpose-rec m1) m1tr)
(check-expect (transpose-rec '((42))) '((42)))

; think, think, think!
; implement transpose non recursively!
; this one's tricky! suggestion: use map and apply
(define (transpose-map m)
  (apply map list m))



(check-expect (transpose-map m1) m1tr)
(check-expect (transpose-map '((42))) '((42)))

;; (mult m1 m2) -> list?
;; m1, m2: list of list of number
;; return the matrix multiplication m1 x m2
;; no recursion: use map and the above transpose function
(define (mult m1 m2)
  (map (lambda (row) (apply map (lambda (col) (apply + (map * row col))) (list (transpose-map m2)) )) m1))

(check-expect (mult m1 m2)
              '((15 18 21)
                (34 41 48)
                (-4 -5 -6)))

(module+ main
   (test)
)
