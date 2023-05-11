% -*- Mode: Prolog -*-

plane(to, ny, 100).
plane(ny, london, 200).
plane(london, bombay, 500).
plane(london, oslo, 50).
plane(bombay, katmandu, 100).
boat(oslo, stockholm, 100).
boat(stockholm, bombay, 1000).
boat(bombay, maldives, 1000).

% trip(?X, ?Y, ?C) iff there is a trip from X to Y that costs C.
% trip(X, Y, C) :- (boat(X, Y, C) ; plane(X, Y, C)) ; (boat(X, Y2, C2) ; plane(X, Y2, C2)), C3 is C - C2, trip(Y2, Y, C3).

% trip_via(?X, ?Y, ?Via)
trip_via(X, _, X).
trip_via(_, Y, Y).
trip_via(X, Y, Via) :- (plane(X, Z, _) ; boat(X, Z, _)), trip_via(Z, Y, Via).

% trip(?X, ?Y, ?C, ?Trip) 
trip(X, Y, C, [X, Y]) :- plane(X, Y, C) ; boat(X, Y, C).
trip(X, Y, C, Trip) :- (plane(X, Y2, C2) ; boat(X, Y2, C2)), trip(Y2, Y, C3, Trip2), append([X], Trip2, Trip), C is C2 + C3.