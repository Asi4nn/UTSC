module Lab6 where

m1 :: (Num a) => [[a]]
m2 :: (Num a) => [[a]]
m3 :: (Num a) => [[a]]

m1 = [[1,0,2],
      [2,1,4],
      [-1,1,-1]]
m2 = [[1,2,3],
      [4,5,6],
      [7,8,9]]
m3 = [[2,2,5],
      [6,6,10],
      [6,9,8]]
m1tr = [[1,2,-1],
        [0,1,1],
        [2,4,-1]]

-- In all of the following, we assume that dimensions of input vectors and matrices are such that
-- the corresponsing operations are well-defined.

-- Make sure your code works on empty vectors and matrices! The empty matrix is represented as [].

-- Make sure your code passes hlint!

-- Provide the shortest solution you can think of. Hint: use zipWith.
-- |vectorAdd v1 v2
-- return the sum of vectors v1 and v2
vectorAdd :: Num a => [a] -> [a] -> [a]
vectorAdd = zipWith (+)

-- Provide the shortest solution you can think of. Hint: use zipWith and any of the already defined
-- functions.
-- |add m1 m2
-- return the sum of matrices m1 and m2
add :: Num a => [[a]] -> [[a]] -> [[a]]
add = zipWith vectorAdd

-- Provide the shortest solution you can think of. Hint: use map.
-- |scalarVectorMult k v
-- return the result of scalar multiplication of vector v by scalar k
scalarVectorMult :: Num a => a -> [a] -> [a]
scalarVectorMult k = map (* k)

-- Provide the shortest solution you can think of. Hint: use map and "." and any of the already
-- defined functions.
-- |scalarMult k m
-- return the result of scalar multiplication of matrix m by scalar k
scalarMult :: Num a => a -> [[a]] -> [[a]]
scalarMult = map . scalarVectorMult

-- Provide a recursive version that uses map.
-- |transposeMatrix m
-- return the transpose of matrix m
transposeMatrix :: Num a => [[a]] -> [[a]]
transposeMatrix [] = []
transposeMatrix ([] : _) = []
transposeMatrix m = map head m : transposeMatrix (map tail m)

-- Provide the shortest solution you can think of. Hint: use a couple of maps and any of the already
-- defined functions.
-- |mult m1 m2
-- return the product of matrices m1 and m2
mult :: Num a => [[a]] -> [[a]] -> [[a]]
mult m1 m2 = map (\row -> map (dotProduct row) (transposeMatrix m2)) m1

-- Provide the shortest solution you can think of. Hint: use zipWith and sum.
-- If you are brave enough, use a couple of "."s for an even shorter solution!
-- |dotProduct v1 v2
-- return the dot product of v1 and v2
dotProduct :: Num a => [a] -> [a] -> a
dotProduct v1 v2 = sum (zipWith (*) v1 v2)