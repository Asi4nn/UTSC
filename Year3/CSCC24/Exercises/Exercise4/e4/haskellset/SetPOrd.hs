module SetPOrd where

import Set
import POrd
import SetEq

instance (Eq a) => POrd (Set a) where
    pcompare :: Eq a => Set a -> Set a -> POrdering
    pcompare (Set xs) (Set ys)
        | subset xs ys && Set xs /= Set ys = PLT
        | subset ys xs && Set xs /= Set ys = PGT
        | Set xs == Set ys = PEQ
        | not (subset ys xs || subset xs ys) = PIN