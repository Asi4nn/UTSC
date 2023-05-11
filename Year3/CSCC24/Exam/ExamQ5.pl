% -*- Mode: Prolog -*-

nat(zero).
nat(s(N)) :- nat(N).

subtract(X, zero, X).
subtract(X, s(Y), Z) :- subtract(X, Y, s(Z)).