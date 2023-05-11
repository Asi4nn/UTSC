module TestProp where
import Prop
import Test.HUnit

f1 :: Formula
f1 = Variable "x"
f2 :: Formula
f2 = Implies (Variable "a") (And [Variable "b", Neg Fls])

testShow = TestList [testShowVar, testShowSimple]

testShowVar = TestCase $ assertEqual
                        ("show f1 is ") "Variable \"x\""
                        (show f1)

testShowSimple = TestCase $ assertEqual
                        ("show f2 is ") "Implies (Variable \"a\") (And [Variable \"b\",Neg Fls])"
                        (show f2)

testSub = TestList [testSubSingle, testSubSimple]

testSubSingle = TestCase $ assertEqual
                        ("sub f1:") Tru
                        (sub f1 [("x", True)])

testSubSimple = TestCase $ assertEqual
                        ("sub f2:") (Implies Tru (And [Fls,Neg Fls]))
                        (sub f2 [("a", True), ("b", False)])

testEval = TestList [testEvalSingle, testEvalSimple]

testEvalSingle = TestCase $ assertEqual
                        ("eval f1:") True
                        (eval f1 [("x", True)])

testEvalSimple = TestCase $ assertEqual
                        ("sub f2:") False
                        (eval f2 [("a", True), ("b", False)])

tests = TestList [testShow, testSub, testEval]

main = runTestTT tests

