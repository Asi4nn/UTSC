module Trees where

-- |A binary tree.
data Tree a = Leaf a | Node a (Tree a) (Tree a)

-- |countNodes t
-- return the number of all nodes in tree t
countNodes:: Tree a -> Int
countNodes (Leaf _) = 1
countNodes (Node _ t1 t2) = 1 + countNodes t1 + countNodes t2

-- |forallNodes p t
-- return whether p is true of every node in tree t
forallNodes:: (a -> Bool) -> Tree a -> Bool
forallNodes p (Leaf t) = p t
forallNodes p (Node a t1 t2) = p a && forallNodes p t1 && forallNodes p t2

-- |existsNode p t
-- return whether p is true of some node in tree t
existsNode:: (a -> Bool) -> Tree a -> Bool
existsNode p (Leaf t) = p t
existsNode p (Node a t1 t2) = p a || existsNode p t1 || existsNode p t2

-- |inorder t
-- return a list of nodes in t in inorder traversal order
inorder:: Tree a -> [a]
inorder (Leaf t) = [t]
inorder (Node a t1 t2) = inorder t1 ++ (a : inorder t2)

tfold:: (a -> b) -> (a -> b -> b -> b) -> Tree a -> b
tfold f g (Leaf x) = f x
tfold f g (Node x left right) = g x (tfold f g left) (tfold f g right)

countNodes':: Tree a -> Int
countNodes' = tfold (const 1) (\a t1 t2 -> 1 + t1 + t2)

forallNodes':: (a -> Bool) -> Tree a -> Bool
forallNodes' p = tfold p (\a t1 t2 -> p a && t1 && t2)

existsNode':: (a -> Bool) -> Tree a -> Bool
existsNode' p = tfold p (\a t1 t2 -> p a || t1 || t2)

inorder':: Tree a -> [a]
inorder' = tfold (: []) (\a t1 t2 -> t1 ++ (a : t2))
