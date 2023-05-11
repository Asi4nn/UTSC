module Lab5 where

-- Translate the following Scheme expressions into Haskell.

-- (define life 42)
life = 42

-- (define life' (+ 42 24))
life' = 42 + 24

-- assert the types of life and life'
life :: Integer
life' :: Integer

-- (define (implies a b) (if a b True))
implies (a, b) = not a || b

-- assert the type of implies
implies :: (Bool, Bool) -> Bool

-- (define (greet x) (string-append "hello, " x))
greet x = x ++ "hello"

-- assert the type of greet
greet :: [Char] -> [Char]

-- define a function repeatTwice that repeats each element in the given list twice
repeatTwice lst = if null lst then [] else head lst : head lst : repeatTwice (tail lst)

-- assert the type of repeatTwice
repeatTwice :: [a] -> [a]

-- let's look at a better way! (listen to your TA!)

-- now let's use pattern matching to produce a much better solution
-- call it repeatTwice'
repeatTwice' [] = []
repeatTwice' (x : xs) = x : x : repeatTwice' xs
-- assert the type of repeatTwice'
repeatTwice' :: [a] -> [a]

-- define len (length of list) using pattern matching
len [] = 0
len (_ : xs) = 1 + len xs

-- what is the type of len?
-- [a] -> Int

-- define firsts that takes a list of pairs and returns a list of its first elements
-- use pattern matching
firsts ((a, _) : xs) = a : firsts xs

-- what is the type of firsts?
-- [(a, b)] -> [a]

-- define rev which returns the reverse of the input list
-- use pattern matching
rev [] = []
rev (x : xs) = reverse xs ++ [x]

-- what is the type of reverse?
-- [a] -> [a]

-- now define a tail-recursive linear-time version of rev called rev'
-- you can use "let" or "where": look them up! https://wiki.haskell.org/Let_vs._Where
rev' lst = rev't (lst, [])
  where rev't (xs, acc) | null xs = acc
                        | otherwise = rev't (tail xs, head xs : acc)

main = do
  print "Lab 5"
  print $ greet "Anya"
  print $ repeatTwice' "cscc24"
