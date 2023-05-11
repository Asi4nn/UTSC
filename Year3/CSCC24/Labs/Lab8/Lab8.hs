module Lab8 where

import Data.List

-- recall our datatype for binary trees from class
data BTree a = Empty | Node a (BTree a) (BTree a)

t = Node 10
    (Node 5
     (Node 2 Empty Empty)
     (Node 7
      (Node 6 Empty Empty)
      Empty))
    (Node 15
     Empty
     (Node 20 Empty Empty))

t' = Node 10
     (Node 15
      (Node 6 Empty Empty)
      (Node 20 Empty Empty))
    (Node 5
     (Node 2 Empty Empty)
     (Node 7 Empty Empty))

-- |preorder t
-- return a list of values in t, in preorder traversal order
-- preorder :: BTree a -> [a]
preorder Empty = []
preorder (Node a tl tr) = a : preorder tl ++ preorder tr


-- We want to be able to compare BTrees for equality. We decide that two BTrees are equal if they
-- contain the same elements (you may assume no duplicates). The shapes of the trees do not determine
-- whether the trees are equal.

instance (Eq a) => Eq (BTree a) where
     Empty == Empty = True
     n1 == n2 = subset (preorder n1) (preorder n2) && subset (preorder n2) (preorder n1) where
          subset s t = all (`elem` t) s


-- we want to be able to display BTrees as follows (tilt your head to
-- the left!)
--    20
--  15
--10
--    7
--      6
--  5
--    2

instance (Show a) => Show (BTree a) where
     show t = concat (reverseorder t 0) where
          reverseorder :: (Show a) => BTree a -> Int -> [String]
          reverseorder Empty _ = []
          reverseorder (Node a tl tr) d = reverseorder tr (d + 2) ++ (concat (replicate d " ") ++ show a ++ "\n") : reverseorder tl (d + 2)

-- Let's create a type class Sized, which prescribes a function
-- size :: a -> Int, and provides definitions for
-- empty :: a -> Bool and nonempty :: a -> Bool

class Sized a where
     size :: a -> Int
     empty :: a -> Bool
     nonempty :: a -> Bool
     empty a = size a == 0
     nonempty = not . empty

-- now let's state that all Bool's are of size 1, by defining
-- a corresponding instance

instance Sized Bool where
     size b = 1

-- now let's make lists Sized, by defining the size of a list
-- to be its length

instance Sized [a] where
     size = length

-- finally, let's make our BTree's Sized, by defining the size of a BTree
-- to be the number of the elements stored in it

instance Sized (BTree a) where
     size = length . preorder
