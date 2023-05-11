module Prop where

-- Formula datatype
data Formula = Tru
    | Fls
    | Variable String
    | Neg Formula
    | And [Formula]
    | Or [Formula]
    | Implies Formula Formula
    deriving (Show, Eq)

-- |sub f asst
-- returns the formula f with the substitutions given in asst
sub :: Formula -> [(String, Bool)] -> Formula
sub Tru _ = Tru
sub Fls _ = Fls
sub (Variable v) asst = case lookup v asst of
  Just f -> (if f then Tru else Fls)
  Nothing -> Variable v
sub (Neg f) asst = Neg (sub f asst)
sub (And fs) asst = And (map (`sub` asst) fs)
sub (Or fs) asst = Or (map (`sub` asst) fs)
sub (Implies f0 f1) asst = Implies (sub f0 asst) (sub f1 asst)

-- |eval f asst
-- returns the result of evaluating 'f' with variable assignment 'asst'
-- Pre: All variables appearing in f must be assigned in asst
eval :: Formula -> [(String, Bool)] -> Bool
eval Tru _ = True
eval Fls _ = False
eval (Variable v) asst = case lookup v asst of
  Just b -> b
  Nothing -> error "Unassigned variable" -- should not run given the precondition is filled
eval (Neg f) asst = not (eval f asst)
eval (And fs) asst = all (`eval` asst) fs
eval (Or fs) asst = any (`eval` asst) fs
eval (Implies f0 f1) asst = not (eval f0 asst) || eval f1 asst
