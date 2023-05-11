module SetEq where

import Set

instance (Eq a) => Eq (Set a) where
    Set xs == Set ys = subset xs ys && subset ys xs