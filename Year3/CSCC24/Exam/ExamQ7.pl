% -*- Mode: Prolog -*-

needToDo(monday, cscc24).
needToDo(wednesday, cscc24).
needToDo(monday, abcc23).
needToDo(tuesday, abcc23).
needToDo(wednesday, abcc23).
like(cscc24).
dontLike(abcc23).
needToWatchTV(wednesday).
needToWatchTV(thursday).
needToWatchTV(friday).

% procrastinate(Day, Task) :- needToDo(Day, Task), dontLike(Task).
% procrastinate(Day, Task) :- needToDo(Day, Task), needToWatchTV(Day).
% procrastinate(Day, Task) :- needToDo(Day, Task), needToDo(Day, Task2), Task \= Task2, like(Task2).

procrastinate(Day, Task) :- needToDo(Day, Task), pHelper(Day, Task).

pHelper(_, Task) :- dontLike(Task), !.
pHelper(Day, Task) :- needToDo(Day, Task), needToWatchTV(Day), !.
pHelper(Day, Task) :- needToDo(Day, Task), needToDo(Day, Task2), Task \= Task2, like(Task2), !.