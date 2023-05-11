% -*- Mode: Prolog -*-

% member/2 means member has 2 arguments
% specifing preconditions:
% foo(+X) means X must be instantiated
%    foo(a) is OK, foo(X) is not
% foo(-X) means X is not instantiated (it is a variable)
% foo(?X) means X can be either
% Note on testing: when testing foo(?X), need test cases with
%  X both instantiated and non-instantiated

% member(?X,?List) iff X is an element of List
member(X, [X, _]).
member(X, [_, Rest]) :- member(X, Rest).

% append(?X,?Y,?Z) iff Z is the result of
%  appending list Y to list X
append([], Y, Y).
append([H|T], Y, [H|Z]) :- append(T, Y, Z).

% mylength(?L, ?N) iff N is the length of list L.
mylength([], 0).
mylength([_|T], N) :- mylength(T, NT), N is NT + 1.

% First try:

% Second try:

% Third try:

% Finally:


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
male(charlie).
male(bob).
male(albert).
female(eve).

parent(charlie,bob).
parent(eve,bob).
parent(charlie,albert).
parent(eve,albert).

% First try: get duplicate answers.
% son(X):-parent(_,X), male(X).

% Try cut.
% son(X) :- parent(_, X), male(X), !.

% Try cut in another way.
% son(X) :- parent(_, X), !, male(X).

% Now think first, then cut!
son(X) :- male(X), hasParent(X).
hasParent(X) :- parent(_, X), !.

% cuts will not allow backtracking for anything before the cut was indroduced up the the rule which contains the cut.

% Our very first try: get duplicate answers, also bob is sibling of bob.
%sibling(X,Y) :- parent(P, X), parent(P, Y).

% Fix duplicate answers with cut:
% sibling(X, Y) :- person(X), person(Y), hasSameParent(X, Y).
person(X) :- male(X) ; female(X).
hasSameParent(X, Y) :- parent(P, X), parent(P, Y), !.

% Now fix the "bob is sibling of bob" problem. Try one: not a safe use of negation!
sibling(X, Y) :- person(X), person(Y), X \= Y, hasSameParent(X, Y).