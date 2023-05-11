#lang racket

(require test-engine/racket-tests)

; returns a function which increments its input by x
(define (make-inc x)
  (lambda (y) (+ x y)))

(define inc-by-5 (make-inc 5))
;(inc-by-5 100)

(define inc-by-10 (make-inc 10))
;(inc-by-10 100)

;(define (plus-x y)
;  (+ x y))

(define x 100)
(define (plus-x y) ; captures environment which x = 100
  (+ x y))

;(plus-x 10)

(let ([x 200])
  (set! x 200) ;will only change the enclosing scope's x
  (plus-x 10)) ;still 110

(set! x 200) ; set x in the current scope to 200
(plus-x 10) ; 210


(define counter
  (let ([count 0]) ;start of environment
    (lambda () ;with a function makes a closure
      (set! count (+ count 1))
      count)))

(counter)
(counter)
(counter)

(define make-counter
  (let ([global-count 0]) ;same for all instances of make-counter
    (lambda ()
      (let ([local-count 0]) ;is created for each instance of make-counter
        (lambda ()
          (set! global-count (+ global-count 1))
          (set! local-count (+ local-count 1))
          (cons global-count local-count))))))

(define counter1 (make-counter))
(define counter2 (make-counter))

(counter1)
(counter1)
(counter2)
(counter2)
(counter1)

;;;;;;;;;;;;;;;;;;;;;;;  CONTINUATION PASSING STYLE ;;;;;;;;;;;;;;;;;;;;;

; (my-length xs) -> integer?
; xs: list?
; return the number of elements in xs
(define (my-length-rec xs)   ; return length[xs]
  (if (empty? xs)
      0
      (+ 1 (my-length-rec (rest xs)))))

(check-expect (my-length-rec '()) 0)
(check-expect (my-length-rec '(42)) 1)
(check-expect (my-length-rec '(1 2 (3 6) 4 5)) 5)

; [length '[1 2]]             <--- new stack frame
; [+ 1 [length '[2]]]         <--- new stack frame
; [+ 1 [+ 1 [length '[]]]]    <--- new stack frame
; [+ 1 [+ 1 0]]               <--- pop
; [+ 1 1]                     <--- pop
; 2                           <--- pop

(define (my-length-tail xs)   ; return length[xs]
  (local
    [(define (my-len-t xs acc)  ; return length[xs] + acc
       (if (empty? xs)
           acc
           (my-len-t (rest xs) (+ acc 1))))]
    (my-len-t xs 0)))

(check-expect (my-length-tail '()) 0)
(check-expect (my-length-tail '(42)) 1)
(check-expect (my-length-tail '(1 2 (3 6) 4 5)) 5)

; [length-tail '[1 2]]      <--- new stack frame
; [len-t '[1 2] 0]          <--- new stack frame
; [len-t '[2] 1]
; [len-t '[] 2]             <--- pop
; 2                         <--- pop
; Only need one extra for the call to helper! Can reuse space for the rest.


(define (my-length-cps xs)   ; return length[xs]
  (local
    [(define (len-cps xs k)  ; return length[xs] + acc
       (if (empty? xs)
           (k 0)
           (len-cps (rest xs) (lambda (v) (k (+ v 1))))))]
    (len-cps xs identity)))

(check-expect (my-length-cps '()) 0)
(check-expect (my-length-cps '(42)) 1)
(check-expect (my-length-cps '(1 2 (3 6) 4 5)) 5)

; [length-cps '[1 2]]
; [length-cps '[1 2] [lambda [x] x]]
; [length-cps '[1 2] [lambda [x] [[lambda [x] x] [+ 1 v]]]]

; in general: [(lambda (x) (procedure x)) expr] = (procedure expr)

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
    [(define (foldr-cps xs k)
       (if (empty? xs)
           (k id)
           (foldr-cps (rest xs) (lambda (x) (k (f (first xs) x))))))]
    (foldr-cps xs identity)))

; [foldr-tail + 0 [3 4]]
; [foldr-cps [3 4] identity]
; [foldr-cps [4] [lambda (x) (identity (+ 3 x))]]
; [foldr-cps [] [lambda (x) (identity (+ 3 x))] ]

(check-expect (foldr-tail * 1 '(1 2 3))
              6)
(check-within (foldr-tail max -inf.0 '(9 20 5 6 78 100 10000))
              10000.0
              0.01)
(check-expect (foldr-tail cons '() '(1 2 3)) '(1 2 3))
(check-expect (foldr-tail list '() '(1 2 3)) '(1 (2 (3 ()))))

(test)