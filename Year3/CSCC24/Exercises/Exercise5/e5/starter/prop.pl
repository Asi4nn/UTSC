% -*- Mode : Prolog -*- 

:- module(prop, [formula/1, eval/3, sub/3]).

% formula(?F)
formula(tru).
formula(fls).
formula(neg(F)) :- formula(F).
formula(variable(F)) :- atom(F).
formula(and([F|[]])) :- formula(F).
formula(and([F|Rest])) :- formula(F), formula(and(Rest)).
formula(or([F|[]])) :- formula(F).
formula(or([F|Rest])) :- formula(F), formula(or(Rest)).
formula(implies(F0, F1)) :- formula(F0), formula(F1).

% sub(?F, ?Asst, ?G)
sub(tru, _, tru).
sub(fls, _, fls).
sub(variable(F), Asst, G) :- member(F/G, Asst).
sub(neg(F), Asst, neg(G)) :- sub(F, Asst, G).
sub(and([]), Asst, and([])).
sub(and([F|Restf]), Asst, and([G|Restg])) :- sub(F, Asst, G), sub(and(Restf), Asst, and(Restg)).
sub(or([F|Restf]), Asst, or([G|Restg])) :- sub(F, Asst, G), sub(or(Restf), Asst, or(Restg)).
sub(implies(F0, F1), Asst, implies(G0, G1)) :- sub(F0, Asst, G0), sub(F1, Asst, G1).

% eval(?F, ?Asst, ?V)
eval(tru, _, tru).
eval(fls, _, fls).
eval(variable(F), Asst, V) :- member(F/V, Asst).

eval(neg(F), Asst, tru) :- eval(F, Asst, fls).
eval(neg(F), Asst, fls) :- eval(F, Asst, tru).

eval(and([]), _, tru).
eval(and([F|Rest]), Asst, tru) :- eval(F, Asst, tru), eval(and(Rest), Asst, tru).
eval(and([F|Rest]), Asst, fls) :- (eval(F, Asst, fls), (eval(and(Rest), Asst, fls) ; eval(and(Rest), Asst, tru))) ; eval(and(Rest), Asst, fls).

eval(or([]), _, fls).
eval(or([F|Rest]), Asst, tru) :- (eval(F, Asst, tru), (eval(or(Rest), Asst, tru) ; eval(or(Rest), Asst, fls))) ; eval(or(Rest), Asst, tru).
eval(or([F|Rest]), Asst, fls) :- eval(F, Asst, fls), eval(or(Rest), Asst, fls).

eval(implies(F0, F1), Asst, tru) :- eval(F0, Asst, tru), eval(F1, Asst, tru) ; 
                                    eval(F0, Asst, fls), eval(F1, Asst, tru) ;
                                    eval(F0, Asst, fls), eval(F1, Asst, fls).
eval(implies(F0, F1), Asst, fls) :- eval(F0, Asst, tru), eval(F1, Asst, fls).
