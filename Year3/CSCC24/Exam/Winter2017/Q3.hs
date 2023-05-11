f (x, y) = x:y

f1 x y = x y

f2 :: Num a1 => (a2 -> a1, [a2], c) -> [a1]
f2 (x, y, z) = 42 : map x y

f3 :: (Foldable t) => t Double -> Double
f3 = foldr (\x y -> x + y + 42.0) 0.0