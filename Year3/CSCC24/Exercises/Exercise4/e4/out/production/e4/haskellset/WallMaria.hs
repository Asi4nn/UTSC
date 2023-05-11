-- /(((((((////////////*,#********************,,,,,,,,,,,,***/#,,///((///******////
-- (((((((((////////*,#****,,*******************,,*,,,,,,,,,,,**,#,,////*******////
-- /////(((///////,/%//**************///#//**************,,,,,******#,/************
-- /////////////*/&%#&((((%(//%/***///&&&%%//*,*%(//%/%#/**#**%**/****%,/**********
-- ///////////(/&&&&&&&&&&&&&%(/&////(%&&&&(/***/%%%%%%%%%%%%%%%%#%/****%.*******//
-- ////////((/&&&&&&&&&#&&&&((///**,////%///*****////%#%%(*****/%%%%%((***,/////(##
-- ////(((##*&&##%(((((/&(///*****,**********,,,**,**************#/%/%#/&**%,%%&&&&
-- ((#%%&&&/&&(//***************,..*,*********//,,*,,,***,,**************/**/,#####
-- ##%&&&&*&&(/***************,,/&,*,******,,(@&((,,,.,,,,,,,,,,,*************,####
-- %%&&&&#%%//*******,,,,,.,,,(&&@*,,,,,,,,,(&&&&&&(,,.,,,,,,,,,,,,,,**********/(##
-- ###%%%*%(**,,,,,,,.,,,..,,&&&&&*.,,,,,,,*&&&&&&&&&@,,,,,,,,,,,,,,,,,,,,,,*,*.///
-- ((###*%%/*,,,,,,,...,..,*&&&&&&,.,.,,,,,**/(((#&&&&&&,,,.,,,,,,,,,,,,,,,,,,,,,**
-- ///((*#/*,,,,,,,,......,&&(((//,,,,,,,./////&@@&&&&%/@,..,,,,,,,,,,,,,,,,,,,,.**
-- //////#*,,,,,,,,,...,@*&@/%(*/@.,,,,,.&@&(,,(,,,,@*/,,*..,,.,,,,,,,,.,,,,,,.,.**
-- ////*##*,,,,,,,,,...@#,,,,.,,((,.,,,(&&&&&&&@/@@*/,&&&&,,,.,,,,,,,,,.,,,,,,.,.,*
-- ////*#**,,,,,,,,,.,.(@&@#@@(,&&,,,,@&&&&&&&&&&&@&&&&&&&%,..,,.,,,,,,.,,,,,,....*
-- ((##*#*,,,,,,,,,..,/&&&&&&&&&&,*,.#&&&&&&&&&&&&&&&&&&&&@,..,..,,,,,..,,,,......*
-- &&&&*#*,,.,,,,,....*&&&&&&&&&%*,&%*&&&&&&&&&&&&&&&&&&&&@,......,,,,..,,,,......*
-- &&&&/#*,,.,,,,,....*&&&&&&&&&*(&@/,&&&&&&&&&&&&&&&&&&&&@*.,..,.,.,...,.,,.....**
-- &@@@##*,,.,,,,,.,. .,&&&&&&&*&&&&&%&&&&&&&&&&&&&&&&&&&&,&.. ..,,.,...,.,......**
-- &&&&@*,,,,,,,.,.....#/&&&&&@&&&&&&&&&&&&&&&&&&&&&&&&&&(&/.....,.. ..,.,......,(%
-- %&&&&,,,,,.,,... ,...@&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&(&@,. ..,.... ... .....,%%%
-- &&&&&/(..,.,,..,... ..@&&&&&&&&&&&%%%%%%&&&&&&&&&&&&&&(/.........      .....,%%&
-- ##%%%%,,.,..,,....,....,@&&&&&&&&&&&&(&&&&&&&&&&&&&&&//... ... ..  . .   ..,%%%%
-- ((((##(*#,,..,... .. ....*@&&&&&&&&&&&&&&&&&&&&&&&(//,........  .  ..   ...##%%&
-- ((%&&&%*#(,...,......  ...,.@&&&&&&&&&&&&&&&&&&@(//.,.. ......  .    .  ..((##%%
-- (((#%&&&*&%,*..,.. .. .. ....,*@&&&&,,.,,,,,,,,,,..... ..   .   .  .... .////(((
-- &&%%%&&&&%&&,*. ,....../.   .. ..,,..............,. ./. ...     .    .*.///////(
-- %###((####%&%./.*,. ..   .  ...................../......./      ../ ./,///**////
-- %%%##((((((##(,#.#....../......................../,...../.*.., .*//,//,///***///
-- (((((((####%%%&&&,&.,&%/,........................//..../,/.,//////.///*/*******/
-- ////////((#,&&/(//#&&,/.,..............         .//,..,//////////////,,*//******
-- ******////(.,,.//////////........      ..........//..../////////////,..,////////
-- ***********(.,,//////////.     ..................//*... */******/**.....///(((%%
-- ********///&,,,*/////./........................../*/....*********/.*.,,,,,.,///*
-- **********,%,,../////............................**/..../****.,.,..,**,******,**
-- ***,,*****,&,..,///*** ..................    ....***.../,******************..**.
-- ,*******(/%/,...****,..              .........*****,***********************..***
-- ,******(%,%,....***.......................***.**********************************
-- /#%%%%%&*%*.....**..... ..........  ....*.*,,*************************,,,,***,#/


-- Disclaimer: I am not responsible if my test cases somehow give you a lower mark
--             on your exercise 4.(*)
-- Location: ~/e4/haskellset/
-- Reasonable Assumptions made:
-- * Multisets != Set

module WallMaria where
import POrd
import Set
import SetEq
import SetPOrd
import SetShow
import Test.HUnit

eint :: Set Int
eint = Set []
a :: Set Int
a = Set [1, 3]
b = Set [2, 3]
anb = Set [3]

testShow = TestList [testShowEmpty, testShowOne, testShowAll]

testShowEmpty = TestCase $ assertEqual
                        ("show eint is ") "{}"
                        (show eint)

testShowOne = TestCase $ assertEqual
                        ("show a is ") "{1,3}"
                        (show a)

testShowAll = TestCase $ assertEqual
                        ("show anb is ") "{3}"
                        (show anb)

testEq = TestList [testEqEmpty1, testEqEmpty2, testEqReg1, testEqReg2]

testEqEmpty1 = TestCase $ assertEqual
                        ("eint == a is ") False
                        (eint == a)

testEqEmpty2 = TestCase $ assertEqual
                        ("eint == eint is ") True
                        (eint == eint)

testEqReg1 = TestCase $ assertEqual
                        ("a == a is ") True
                        (a == a)

testEqReg2 = TestCase $ assertEqual
                        ("a == b is ") False
                        (a == b)

testPOrd = TestList [testPOrdReg1, testPOrdReg2, testPOrdEq1, testPOrdEq2, testPOrdEq3, testPOrdComp1, testPOrdComp2, testPOrdComp3, testPOrdComp4]

data YesOnly = YES | NO deriving (Show, Eq)
data MaybeOnly = MAYBE | SO deriving (Show, Eq)
instance POrd MaybeOnly where
    gt x y = x == MAYBE && y == SO
    gte x y = gt x y || (x == MAYBE && y == MAYBE)
    lt x y = x == SO && y == MAYBE
    lte x y = lt x y || (x == MAYBE && y == MAYBE)
    inc x y = x == SO && y == SO
instance POrd YesOnly where
    pcompare :: YesOnly -> YesOnly -> POrdering
    pcompare x y
        | x == YES && y == x = PEQ
        | x == NO && y == x = PIN
        | x == YES && y == NO = PGT
        | x == NO && y == YES = PLT

testPOrdReg1 = TestCase $ assertEqual
                        ("gte YES NO is ") True
                        (gt YES NO)

testPOrdReg2 = TestCase $ assertEqual
                        ("inc NO NO is ") True
                        (inc NO NO)
testPOrdEq1 = TestCase $ assertEqual
                        ("gte YES YES is ") True
                        (gte YES YES)

testPOrdEq2 = TestCase $ assertEqual
                        ("lte YES YES is ") True
                        (lte YES YES)

testPOrdEq3 = TestCase $ assertEqual
                        ("lte YES YES is ") False
                        (lte NO NO)

testPOrdComp1 = TestCase $ assertEqual
                        ("pcompare MAYBE SO is ") PGT
                        (pcompare MAYBE SO)

testPOrdComp2 = TestCase $ assertEqual
                        ("pcompare SO MAYBE is ") PLT
                        (pcompare SO MAYBE)

testPOrdComp3 = TestCase $ assertEqual
                        ("pcompare MAYBE MAYBE is ") PEQ
                        (pcompare MAYBE MAYBE)

testPOrdComp4 = TestCase $ assertEqual
                        ("pcompare SO SO is ") PIN
                        (pcompare SO SO)

testSetPOrd = TestList [testSPOReg1, testSPOReg2, testSPOReg3, testSPOInc2, testSPOEmpty1, testSPOEmpty2]

data AOT = EREN | MIKASA | ARMIN | COLOSSAL | ARMORED | LEVI | ERWIN deriving (Eq, Show)
enemy = Set [COLOSSAL, ARMORED]
corps = Set [EREN, MIKASA, ARMIN, COLOSSAL, ARMORED]
commanders = Set [LEVI, ERWIN]
empty :: Set AOT
empty = Set []

testSPOReg1 = TestCase $ assertEqual
                        ("pcompare enemy enemy is ") PEQ
                        (pcompare enemy enemy)

testSPOReg2 = TestCase $ assertEqual
                        ("lt enemy corps is ") True
                        (lt enemy corps)    

testSPOReg3 = TestCase $ assertEqual
                        ("gte corps enemy is ") True
                        (gte commanders commanders)

testSPOReg4 = TestCase $ assertEqual
                        ("gte corps enemy is ") True
                        (gte corps enemy)

testSPOInc2 = TestCase $ assertEqual
                        ("inc corps commanders is ") True
                        (inc corps commanders)

testSPOEmpty1 = TestCase $ assertEqual
                        ("gte corps enemy is ") True
                        (gte corps enemy)

testSPOEmpty2 = TestCase $ assertEqual
                        ("pcompare empty empty is ") PEQ
                        (pcompare empty empty)

tests = TestList [testShow, testEq, testPOrd, testSetPOrd]

main = runTestTT tests

