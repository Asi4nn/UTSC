module Lab7 where

-- mathematical expressions
-- leafs are numbers (integers)
-- internal nodes are either unary functions with one child
-- or binary functions with two children
data MathTree = Leaf Integer
              | Unary (Integer -> Integer) MathTree
              | Binary (Integer -> Integer -> Integer) MathTree MathTree

-- This is here to let Haskell know how to display the MathTree to you.
-- We will learn later what exactly this is and how it works.
instance Show MathTree where
    show (Leaf v) = show v
    show (Unary f t) = "unary(" ++ show t ++ ")"
    show (Binary f l r) = "binary(" ++ show l ++ "," ++ show r ++ ")"

-- |eval t
-- return the result of evaluating t
eval :: MathTree -> Integer
eval (Leaf t) = t
eval (Unary f t) = f (eval t)
eval (Binary f t1 t2) = f (eval t1) (eval t2)

-- |apply op t
-- return the result of applying op to every leaf in t
apply :: (Integer -> Integer) -> MathTree -> MathTree
apply op (Leaf t) = Leaf (op t)
apply op (Unary f t) = Unary f (apply op t)
apply op (Binary f t1 t2) = Binary f (apply op t1) (apply op t2)

-- |element v t
-- return whether v is in t
element :: Integer -> MathTree -> Bool
element v (Leaf t) = t == v
element v (Unary _ t) = element v t
element v (Binary _ t1 t2) = element v t1 || element v t2

-- |replace v v' t
-- return the result of replacing every value v in the leafs of t with v'
replace :: Integer -> Integer -> MathTree -> MathTree
replace v v' (Leaf t) = if t == v then Leaf v' else Leaf t
replace v v' (Unary f t) = Unary f (replace v v' t)
replace v v' (Binary f t1 t2) = Binary f (replace v v' t1) (replace v v' t2)

-- |sumLeafs t
-- return the sum of the leafs of t
sumLeafs :: MathTree -> Integer
sumLeafs (Leaf t) = t
sumLeafs (Unary _ t) = sumLeafs t
sumLeafs (Binary _ t1 t2) = sumLeafs t1 + sumLeafs t2

-- |numNodes t
-- return the number of all nodes in t (including leaf and internal nodes)
numNodes :: MathTree -> Int
numNodes (Leaf _) = 1
numNodes (Unary _ t) = 1 + numNodes t
numNodes (Binary _ t1 t2) = 1 + numNodes t1 + numNodes t2 

-- |numLevels t
-- return the number of levels in t (i.e., return the number of nodes on the longest root-to-leaf
-- path in t)
numLevels :: MathTree -> Int
numLevels (Leaf _) = 1
numLevels (Unary _ t) = 1 + numLevels t
numLevels (Binary _ t1 t2) = 1 + max (numLevels t1) (numLevels t2)

-- |tflip t
-- return a tree which is a result of swapping, for every binary node in the tree, its right and
-- left child
tflip :: MathTree -> MathTree
tflip (Leaf t) = Leaf t
tflip (Unary f t) = Unary f (tflip t)
tflip (Binary f t1 t2) = Binary f (tflip t2) (tflip t1)
