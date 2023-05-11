module POrd where

import Set

class (Eq a) => POrd a where
    pcompare :: a -> a -> POrdering
    lt, gt, lte, gte, inc :: a -> a -> Bool
    pcompare xs ys
        | lt xs ys = PLT
        | gt xs ys = PGT
        | lte xs ys && gte xs ys = PEQ
        | inc xs ys = PIN
    lt xs ys = lte xs ys && not (gte xs ys)
    gt xs ys = gte xs ys && not (lte xs ys)
    lte xs ys = pcompare xs ys == PLT || pcompare xs ys == PEQ
    gte xs ys = pcompare xs ys == PGT || pcompare xs ys == PEQ
    inc xs ys = not (lte xs ys || gte xs ys) 
