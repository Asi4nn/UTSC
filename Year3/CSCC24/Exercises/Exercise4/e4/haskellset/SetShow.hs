module SetShow where

import Set

instance (Show a) => Show (Set a) where
    show (Set xs) = "{" ++ toString xs ++ "}"
        where
            toString [] = ""
            toString [x] = show x
            toString (x : xs) = show x ++ "," ++ toString xs
