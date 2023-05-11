% -*- Mode : Prolog -*- 

:- use_module(prop, [formula/1, eval/3, sub/3]).

:- begin_tests(formula).

test(formula_tru) :- formula(tru).
test(formula_fls) :- formula(fls).
test(formula_variable) :- formula(variable(x)), formula(variable('Y')), formula(variable('Z123')).
test(formula_neg) :- formula(neg(tru)), formula(neg(variable(x))), formula(neg(or([tru, fls]))).
test(formula_and) :- formula(and([variable(x), or([neg(variable(y)), variable(z)])])), formula(and([tru, fls, neg(variable(x))])), formula(and([variable('a')])), \+ formula(and([])).
test(formula_or) :- formula(or([variable(x), or([neg(variable(y)), variable(z)])])), formula(or([tru, fls, neg(variable(x))])), formula(or([variable('a')])), \+ formula(or([])).
test(formula_implies) :- formula(implies(tru, fls)), formula(implies(variable(x), or([neg(variable(y)), variable(z)]))), formula(implies(neg(variable(x)), variable('a'))).

:- end_tests(formula).
:- begin_tests(sub).

test(sub_variable) :- sub(variable(x), [x/true], tru), sub(variable(x), [x/fls], fls), sub(variable('Y'), ['Y'/tru], tru), sub(variable('Z123'), ['Z123'/false], fls).
test(sub_neg) :- sub(neg(variable(x)), [x/true], neg(tru)), sub(neg(or([variable(x), neg(variable(y))])), [x/fls, y/true], neg(or([fls, tru]))).
test(sub_and) :- sub(and([variable(x), or([neg(variable(y)), variable(z)])]), [x/fls, y/true, z/true], and([fls, or([tru, tru])])), sub(and([neg(variable(x))]), [x/true], and([neg(tru)])).
test(sub_or) :- sub(or([variable(x), or([neg(variable(y)), variable(z)])]), [x/fls, y/true, z/true], or([fls, or([tru, tru])])), sub(or([neg(variable(x))]), [x/true], or([neg(tru)])).
test(sub_implies) :- sub(implies(variable(x), and([variable(y), neg(fls)])), [x/a, y/b], implies(variable(a), and([variable(b), neg(fls)]))), sub(implies(or([variable(x), variable(y)]), neg(variable(x)))), [x/true, y/false], implies(or([true, false]), neg(true)).

:- end_tests(sub).
:- begin_tests(eval).

test(eval_variable) :- eval(variable(x), [x/true], true), eval(variable(x), [x/fls], false), eval(variable('Y'), ['Y'/false], false), eval(variable('Z123'), ['Z123'/true], true).
test(eval_neg) :- eval(neg(variable(x)), [x/true], false), eval(neg(or([variable(x), neg(variable(y))])), [x/false, y/true], false).
test(eval_and) :- eval(and([variable(x), or([neg(variable(y)), variable(z)])]), [x/true, y/false, z/true], true), eval(and([neg(variable(x))]), [x/false], true).
test(eval_implies_true, [nondet]) :-
    eval(implies(variable(a), variable(b)), [a/tru, b/tru], tru).

test(eval_implies_false, [nondet]) :-
    eval(implies(variable(a), variable(b)), [a/tru, b/fls], fls).

test(eval_implies_true_complex, [nondet]) :-
    eval(implies(and([variable(a), variable(b)]), or([variable(c), neg(variable(a))])), [a/tru, b/tru, c/tru], tru).

test(eval_implies_false_complex, [nondet]) :-
    eval(implies(and([variable(a), variable(b)]), or([variable(c), neg(variable(a))])), [a/tru, b/fls, c/tru], fls).

test(eval_implies_true_nested, [nondet]) :-
    eval(implies(variable(a), implies(variable(b), variable(c))), [a/tru, b/tru, c/tru], tru).

test(eval_implies_false_nested, [nondet]) :-
    eval(implies(variable(a), implies(variable(b), variable(c))), [a/tru, b/tru, c/fls], fls).

test(eval_implies_variable, [nondet]) :-
    eval(implies(variable(a), variable(b)), [a/tru], variable(b)).

test(eval_implies_variable_complex, [nondet]) :-
    eval(implies(and([variable(a), variable(b)]), variable(c)), [a/tru, b/tru], variable(c)).

:- end_tests(eval).
