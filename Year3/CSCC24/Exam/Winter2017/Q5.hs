data Maybe a = Nothing | Something a
data Either a b = This a | That b deriving Show

-- these xs
-- return a list of values from all This's in the list xs.
-- for example, these [This "1", That "2", This "42"] should return ["1","42"]

these :: [Main.Either a b] -> [a]
these [] = []
these (This x : xs) = x : these xs
these (That x : xs) = these xs

-- those xs
-- return a list of values from all That's in the list xs
-- for example, those [This 1, That 2, This 42] should return [2]

those :: [Main.Either a b] -> [b]
those [] = []
those (This x : xs) = those xs
those (That x : xs) = x : those xs

instance (Show a) => Show(Main.Maybe a) where
    show Main.Nothing = ""
    show (Something a) = show a

instance (Eq a) => Eq (Main.Maybe a) where
    Main.Nothing == _ = False
    Main.Something a == Main.Something b = a == b

class MyLogic a where
    not' :: a -> a
    and' :: a -> a -> a
    or' :: a -> a -> a
    implies' :: a -> a -> a
    and' a b = not' (or' (not' a) (not' b))
    or' a b = not' (and' (not' a) (not' b))
    implies' a b = or' (not' a) b

instance MyLogic Bool where
    not' = not
    and' a b = a && b

instance MyLogic [Bool] where
    not' = map not
    and' = zipWith (&&)