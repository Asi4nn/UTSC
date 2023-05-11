data Tree a = Leaf a | Node a (Tree a) (Tree a) deriving Show

many = Node "one" (Node "two" (Leaf "three") (Leaf "four"))
                    (Node "five" (Leaf "six") (Leaf "seven"))

tfold :: (a -> b) -> (a -> b -> b -> b) -> Tree a -> b
tfold f g (Leaf x) = f x
tfold f g (Node x left right) = g x (tfold f g left) (tfold f g right)
choose x y z = if z == x then y else z -- helper for later on

-- fringe t
-- return a list of leaves of t, in left-to-right order
-- for example, fringe many should return ["three","four","six","seven"]
fringe :: Tree a -> [a]
fringe (Leaf a) = [a]
fringe (Node _ a b) = fringe a ++ fringe b

-- replace x y t
-- return a tree just like t, except every occurrence of value x is replaced with y
-- for example, replace "three" "new" many should return
-- Node "one" (Node "two" (Leaf "new") (Leaf "four"))
-- (Node "five" (Leaf "six") (Leaf "seven"))

replace :: Eq t => t -> t -> Tree t -> Tree t
replace x y (Leaf a) = if x == a then Leaf y else Leaf a
replace x y (Node v l r) = if x == v then Node y (replace x y l) (replace x y r) else Node v (replace x y l) (replace x y r)

-- fold versions
fringef = tfold (\(Leaf a) -> [a]) (\_ l r -> l ++ r)

replacef x y = tfold (\v -> if v == x then Leaf y else Leaf v) (\v l r -> if x == v then Node y l r else Node v l r)