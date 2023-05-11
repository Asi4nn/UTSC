import Language.Haskell.TH (listT)
-- enumerated type
data Colour = Red | Green | Blue
c = Red
c :: Colour

-- write a function colourName that takes a Colour and returns the
-- string representing it
colourName Red = "red"
colourName Green = "green"
colourName Blue = "blue"
colourName :: Colour -> String

-- variant type
data Text = Letter Char | Word String

-- write a function textLen that takes a Text and returns the number
-- of chars in it
textLen (Letter _) = 1
textLen (Word w) = length w
textLen :: Text -> Int

-- recursive type (ignore the "deriving Show" part for now)
data LList = Nil | LLNode (Int, LList) deriving Show

llist = LLNode (1, LLNode (2, LLNode (3, Nil)))
llist :: LList

-- write a function llistLen that takes a LList and returns its length
llistLen Nil = 0
llistLen (LLNode (_, next)) = 1 + llistLen next
llistLen :: LList -> Int


-- polymorphic recursive type
data LList' a = Nil' | Node' (a, LList' a) deriving Show

llist' = Node' ('1', Node' ('2', Node' ('3', Nil')))
llist' :: LList' Char

llistLen' Nil' = 0
llistLen' (Node' (_, next)) = 1 + llistLen' next
llistLen' :: LList' a -> Int

-- mathematical expressions
-- leafs are numbers (integers for now)
-- internal nodes are either unary functions and one child
-- or binary functions and two children
data MathExpr' = Leaf' Int
               | Unary' (Int -> Int, MathExpr')
               | Binary' (Int -> Int -> Int, MathExpr', MathExpr')

t' = Binary' ((+),
           Binary' ((+),
                  Unary' (abs,
                        Unary' ((0-),
                               Leaf' 3)),
                  Leaf' 2),
           Binary' ((*),
                  Binary' ((+),
                         Unary' ((0-),
                               Leaf' 1),
                         Leaf' 4),
                  Leaf' 7))
t' :: MathExpr'

-- write a function eval that takes a MathTree and returns its value
eval' (Leaf' x) = x
eval' (Unary' (f, e)) = f (eval' e)
eval' (Binary' (f, l, r)) = f (eval' l) (eval' r)
eval' :: MathExpr' -> Int


-- the curried version:
data MathExpr = Leaf Int
              | Unary (Int -> Int) MathExpr
              | Binary (Int -> Int -> Int) MathExpr MathExpr

t = Binary (+)
           (Binary (+)
                   (Unary abs
                          (Unary (0-)
                                 (Leaf 3)))
                   (Leaf 2))
           (Binary (*)
                   (Binary (+)
                           (Unary (0-)
                                  (Leaf 1))
                           (Leaf 4))
                   (Leaf 7))
-- t :: ?

eval (Leaf x) = x
eval (Unary f t) = f (eval t)
eval (Binary f tl tr) = f (eval tl) (eval tr)
eval :: MathExpr -> Int

-- a binary tree
data BinTree a = EmptyBinTree | BinTreeNode a (BinTree a) (BinTree a)

-- inorder t returns a list of elements of t, in the order of in-order
-- traversal of BTree t
inorder EmptyBinTree = []
inorder (BinTreeNode val left right) = inorder left ++ val : inorder right
inorder :: BinTree a -> [a]

-- Exercise: tail recursive ver of inorder

-- a binary tree with labelled branches
data Tree a = Empty
            | Node (Branch a) (Branch a)
data Branch a = Branch a (Tree a)

-- listTree t return a list of labels of t
listTree Empty = []
listTree (Node lb rb) = listBranch lb ++ listBranch rb
listBranch (Branch v t) = v : listTree t

listTree :: Tree a -> [a]
listBranch :: Branch a -> [a]

lt =
    Node (Branch 1
                (Node (Branch 2 Empty)
                      (Branch 3 (Node (Branch 4 Empty)
                                      (Branch 5 Empty)))))
        (Branch 6
                (Node (Branch 7 Empty)
                      (Branch 8 Empty)))


data First a = Pair a a

-- how can we make == work with Pairs, so that we can say
-- Pair 1 2 == Pair 1 3
-- True
-- Pair 1 2 == Pair 3 4
-- False
-- i.e. == would compare only the first elements of the Pair?

-- What about our very own Type Class?
class YesNo a where
    yesno :: a -> Bool

instance YesNo Integer where
    yesno 0 = False
    yesno _ = True

instance YesNo [a] where
    yesno [] = False
    yesno _ = True

instance YesNo Bool where
    yesno x = x

instance YesNo (Tree a) where
    yesno Empty = False
    yesno _ = True
