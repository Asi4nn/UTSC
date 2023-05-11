  (if (empty? xs) empty
    (foldr (lambda(x y) (cons (f x) y)) '() xs) 
  )
)