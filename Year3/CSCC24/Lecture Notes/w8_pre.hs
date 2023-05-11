data BTree a = Empty | Node a (BTree a) (BTree a)

-- inorder t returns a list of elements of t, in the order of in-order
-- traversal of BTree t
inorder Empty = []
inorder (Node v t1 t2) = (inorder t1) ++ [v] ++ (inorder t2)





data IntPair' = IntPair' Int Int deriving Eq -- Will compare both integers for equality

-- how can we make == work with Pairs, so that we can say
-- Pair 1 2 == Pair 1 3
-- True
-- Pair 1 2 == Pair 3 4
-- False
-- i.e. == would compare only the first elements of the Pair?

data First' = Pair' Int Int

instance Eq First' where
  (Pair' x _) == (Pair' y _) = x == y

-- what about a Pair of any type?
data First a = Pair a a

instance Eq a => Eq(First a) where
  Pair x _ == Pair y _ = True



-- What about our very own Type Class?
class YesNo a where
    yesno, notme :: a -> Bool
    notme = not . yesno
    yesno = not . notme

instance YesNo Integer where
    yesno 0 = False
    yesno _ = True

instance YesNo [a] where
    yesno [] = False
    yesno _ = True

instance YesNo Bool where
    yesno x = x

instance YesNo (BTree a) where
    yesno Empty = False
    yesno _ = True


-- We can provide a default definition of a function in the type class definition:
-- a pair of functions yesno and notme:


-- infinite list of 1's
ones = 1 : ones
tenOnes = take 10 ones

-- list of integers from n and up
numsFrom n = n : numsFrom (n + 1)

-- natural numbers
nats = numsFrom 0

-- all squares of nats
squares = map (^2) nats

-- all odd naturals
odds = filter odd nats

-- all even naturals
evens = filter even nats

-- Fibonacci numbers
fibs = 0 : 1 : zipWith (+) fibs (tail fibs)
-- or:
fibs2 = [0,1,2]

-- is x prime? x does not have divisors from 2 to x-1
prime x = null [n | n <- [2..(x-1)], x `mod` n == 0]

-- all primes
primes = filter prime $ numsFrom 2
