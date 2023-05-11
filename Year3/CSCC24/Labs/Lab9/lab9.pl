% -*- Mode: Prolog -*-
:- module(lab9, [nat/1, sum/3, prod/3]).

female(alice).
female(eve).
female(ida).

male(bob).
male(charlie).
male(frank).
male(gary).
male(harry).

parent(charlie,bob).
parent(eve,bob).
parent(charlie,alice).
parent(eve,alice).
parent(frank,charlie).
parent(gary,frank).
parent(frank, harry).
parent(harry, ida).

% write the following queries (not in this file!):
% -- is alice female? yes
% -- is alice male? no
% -- who is female? alice, eve, ida
% -- who is a parent of bob? charlie, eve
% -- who is a parent? charlie, eve, frank, gary, harry
% -- who are the children of eve? bob, alice

% write the following in first order logic first, and then in Prolog.
% make sure to ask several queries for each of these predicates.

% isaParent(?X) iff X is a parent.
isaParent(X) :- parent(X, _).

% isaChild(?X) iff X is a chld.
isaChild(X) :- parent(_, X).

% isaSon(?X) iff X is a son.
isaSon(X) :- male(X), isaChild(X).

% isaMother(?X) iff X is a mother.
isaMother(X) :- female(X), isaParent(X).

% grandparent(?X,?Y) iff X is a grandparent of Y.
grandparent(X, Y) :- parent(X, Z), parent(Z, Y).

% sibling(?X,?Y) iff X is a sibling of Y.
sibling(X, Y) :- parent(P, X), parent(P, Y), X \= Y.

% cousin(?X, ?Y) iff X is a cousin of Y.
cousin(X, Y) :- parent(P1,X), parent(P2,Y), sibling(P1, P2).

% person(?X) iff X is a person (male or female).
person(X) :- male(X) ; female(X).

% ancestor(?X,?Y) iff X is an ancestor of Y.
ancestor(X, Y) :- parent(X, Y) ; parent(X, Z), ancestor(Z, Y).

% related(?X,?Y) iff X and Y share an ancestor.
related(X, Y) :- ancestor(A, X), ancestor(A, Y).

% Represent all natural numbers as follows:
%  zero, s(zero), s(s(zero)), ...s(0)

% nat(?X) iff X is a natural number represented as above.
nat(zero).
nat(s(N)) :- nat(N).

% sum(+X, +Y, ?Z) iff Z is the sum of X and Y
sum(zero, Y, Y).
sum(s(X), Y, s(Z)) :- sum(X, Y, Z).

% prod(+X, +Y, ?Z) iff Z is the product of X and Y.
prod(zero, _, zero).
prod(s(X),Y,Z) :- sum(F,Y,Z), prod(X,Y,F).