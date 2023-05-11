% -*- Mode: Prolog -*-
:- module(lab10, [trip/2, trip/3, cost/3, reverse/2, intersect/3, union/3]).

% Planning trips in Prolog.
% plane(A,B) means it is possible to travel from A to B on a plane.
% boat(A,B) means  it is possible to travel from A to B on a boat.
plane(to, ny).
plane(ny, london).
plane(london, bombay).
plane(london, oslo).
plane(bombay, katmandu).
boat(oslo, stockholm).
boat(stockholm, bombay).
boat(bombay, maldives).

% cruise(X,Y) -- there is a possible boat journey from X to Y.
cruise(X, Y) :- boat(X, Y) ; boat(X, Z), cruise(Z, Y).

% trip(X,Y) -- there is a possible journey (using plane or boat) from X to Y.
trip(X, Y) :- (boat(X, Y) ; plane(X, Y)) ; (boat(X, Z) ; plane(X, Z)), trip(Z, Y).

% Now, let's add costs to out trips.
plane(to, ny, 100).
plane(ny, london, 200).
plane(london, bombay, 500).
plane(london, oslo, 50).
plane(bombay, katmandu, 100).
boat(oslo, stockholm, 100).
boat(stockholm, bombay, 1000).
boat(bombay, maldives, 1000).

% trip(X,Y,C) -- there is a trip from X to Y that costs C.
trip(X, Y, C) :- (boat(X, Y, C) ; plane(X, Y, C)) ; (boat(X, Y2, Z) ; plane(X, Y2, Z)), C2 is C-Z, trip(Y2, Y, C2).
% cost(X,Y,C) -- there is a trip from X to Y that costs less than C.
cost(X, Y, C) :- trip(X, Y, C2), C2 < C.

% Practise working with lists in Prolog.

% reverse(?L, ?R) iff R is the reverse of list L.
% hint: use append/3.
reverse([], []).
reverse([L|Rest], R) :- reverse(Rest, LR), append(LR, [L], R).

% complexity of reverse?

% linear-time reverse with an accumulator
reverse(L, R) :- reverseAcc(L, [], R).

reverseAcc([], Acc, Acc).
reverseAcc([L|Rest], Acc, R) :- reverseAcc(Rest, [L|Acc], R).

% intersect(+X,+Y,?Z) iff Z is the intersection of X and Y
% hint: there is a built-in member/2.
intersect(X, Y, Z) :- findall(E, (member(E, X), member(E, Y)), Z).

% union(+X,+Y,?Z) iff Z is the union of X and Y
union(X, Y, Z) :- findall(E, (member(E, X) ; member(E, Y)), Z).

% Now what if we want to know not only whether there is a trip from X to Y, but what
% the trip is?
% full_trip(X,Y,T,C) iff there is a trip T from X to Y with the cost of C. T is a list
%  locations, in order, visited on this trip, beginning with X and ending with Y.
full_trip(X, Y, [T], [X, Y]) :- plane(X, Y, C) ; boat(X, Y, C).
full_trip(X, Y, [X|T], C) :- (plane(X, Z, C1) ; boat(X, Z, C1)), full_trip(Z, Y, T, C2), C is C1 + C2.
