-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- %%%*./@@@@@@@@@@*   .....,..      .....................,,,,##%/ @@@@%@@@@@@@@@@@
-- %*####,@@@@.((,,........  ........      ................,,,,**(### #@@@@@@@@@@@@
-- %,**(#/**(,,.*,........................ ..............,,,,*******#/#/ @@@@@@@@@@
-- %,,,*.(##,(,,#,,,,,,,,,,...........................,,*,**#*/*###*//(/(% %@@@@@@@
-- %,,/#( %**##****#*,,,,,,,,,,,..................,,,,****#////##///(%(#***#.@@@@@@
-- %,. ,(%#%##//##(/******,,,,,,,,,,,,,,,,,,,,,,,*****(//%##/(//#(*#(***(#***# @@@@
-- %..###(,%%%%(%#(#/#//****(*****(/******,,,***/**/*#(/*//(*#*/***#*,****,,* ,,@@@
-- %((./..#,#*/%%%%%//(//#/////%//(%/(/***,,****** ***,,,******,,,,,,.,,,,,,,//./&@
-- %,,    ..,***//#////(*///#/#///*****,,,,,,,,,.,, ... ....................../%( @
-- %*      .,,.,,,.**,.,,.,,**.,,,,,,,,,,,,, ... ..... .   ... . ...............%&.
-- %       .  ,,,.,, ., .... ........... ... ....  .. ./  /. .    ... ........./  ,
-- %         ,.. .. .  ...  ...  ..    ... ....   .. ,// *#/  .   .... .......,.,,,
-- %        . . .     ..   ..  ......... ....    .  //#/ %&#/      .    . ..../ /.*
-- %         .       .   ..   ........  ...  ./ . ,/%&(/ &&&/.   /      . ....* / .
-- %                         . . ...  ..  .///   /#&&&/*(&&&//  ./*     .    .* ,.(
-- %                       . . ...  ..  //(/,  /%&&&&%/ &&&&//  *(/          .( ,.(
-- %                        . ..  .. .//&(/  /&&&&&&&/,&&&&&//  (&/        . .#**.(
-- %                       . .   . ./(&#/ .&&&&&&&&&((%&&&&&/* #&&/  *.   *  ../.*(
-- %                        .    ./&&#,.&&&&&&&&&&&#%%&&&&&&/ %&,   ,//   ./ (/@ /(
-- %             ,//          / /&/. .... .&&&&&&&(&&&&&&&&(,.     .&%&  *@*..@(&@@
-- %             ,,//,       / %%  (* .,.  .    *#%@&*&&&%    ,.%@@.&@. /@@.*@@%@@@
-- %            ,*//./*   . /*%&*/(,./  ., (..*.  /&/%&&&...# , &@@(&*%,@@@/@@@@@@@
-- %    ,, .    ./// .*,  /*/*(&## (* ((( @@@%&/%&&&&&&&/(&(. %@@#%&@% @@@,@@@@@@@@
-- % *(#/.  .     ,/.,./,./////&&&%% /@@@@(*(%&&&&&&&&&&/&&&&&&&&&&@*#@@@&@@@@@@@@@
-- %                //* ///////%&&&&&&&&&&&&&&&&&&&&&&&&%&&&&&&&&&&&@@@@@@@@@@@@@@@
-- %                 */////////%&&&&&&&&&&&&&&&&&&&&&&&&*&&&&&&&&&@,@@@@@@@@@@@@@@@
-- %,,.     /           , /////#&&&&&&&&&&&&&&&&&&&&&&&&&#&&&&&&&@,@@@@@@@@@@@@@@@@
-- %,,,,,,,. ,(. .  ,  *,, ////(&&&&&&&&&&&&&&&&&&/,,/// &&&&&&&@(@@@@@@@@@@@@@@@@@
-- %       .,,,,,.. /* //,, ////(&&&&&&&&&&&&&&&&&&&///&&&&&&&&@*@@@@@@@@@@@@@@@@@@
-- %               .,,,.,/,,.,////%&&&&&&&&&&&&&&@&&&#,  &&&&@@(@@@@@@@@@@@@@@@@@@@
-- %                      .,,..////#&&&&&&&&/.,,,,,,(*# &&&&@.@@@% .    &@@@@@@@@@@
-- %              ....     ..      ,/#&&&&&&& #(&@@@@/&&&&&,*(/, .,,,,,***.&@@@@@@@
-- &,,,,,,,,,,,,,,...                 .,*, .  .,,.. .*%%#  .,   ,.,,,       ..(.  #
-- %                .,,,,,,,,,,,,,,.  /%#(/*,,,,,,,,,**/##/ ,#%## /%%%%%%%%%##%&,.,
-- %         .,,,,,,,,,,.        (##/**,,,,,,,,,,.   .(#(/*,,,. (((((((,..,.,. ####
-- %   ..,,,,,,,.            (#(**,,,,,,,.      .*#(***,,,, , ((((..,...,. (##((((#
-- %,,,,.               .(#(**,,,,,.         (#/**,,,,,,  , .........../#((((((*..*
-- %                 ,##**,,,,,          ((**,,,,.,,,   . ..... ... #((((((.......*
-- %              ,##**,,,,          ,(***,,,,,,,,       .......((((((*....... *((#
-- %           *##**,,,.          (*,,,,*.(**,.        ....,(((((*.......*((((((*.*
-- %        *##/*,,,.          *,,,,*,*(**,.          ./((((*......(((((((,.......*
-- %     ,##(**,,,          ,,,,,* #(**,           ........./(((((/...............*
-- %  ,###/**,,.         .,,,**.#(**,            ..,(((((*,.......................*
-- %####**,,,          ,,,**.##**,             .................................. (
-- %#/**,,.         ,,,**.##**,.            ................................  ....*
-- %**,,.        .,,**,##/**,             .............................   ........*
-- %,,.        ,,***##(**,.            ............................               .
-- %,        ,**/(##**,,             ......................... ,#( &&&&&&&&*    ..(
-- %      .,***##/**,.             .....................  *(((((#../..(  (...     ,

-- Disclaimer: I am not responsible if my test cases somehow give you a lower mark
--             on your exercise 4.(*)
-- Location: ~/e4/

module TitanForest where
import Trees
import Test.HUnit

{- Starter -- Test Trees SSR EX -}

one = Leaf "one"
three :: Tree String
three = Node "one" (Leaf "two") (Leaf "three")
five = Node "one" (Leaf "two") (Node "three" (Leaf "four") (Leaf "five"))
seven = Node "one" (Node "two" (Leaf "three") (Leaf "four")) (Node "five" (Leaf "six") (Leaf "seven"))
long xs = length xs > 4

testCountNodes = TestList [testCountThreeExample, testCountOneExample, testCountFiveExample, testCountSevenExample]
testCountThreeExample = TestCase $ assertEqual
                        ("countNodes three is ") 3
                        (countNodes three)
testCountOneExample = TestCase $ assertEqual
                        ("countNodes one is ") 1
                        (countNodes one)

testCountFiveExample = TestCase $ assertEqual
                        ("countNodes five is ") 5
                        (countNodes five)

testCountSevenExample = TestCase $ assertEqual
                        ("countNodes seven is ") 7
                        (countNodes seven)

testForallNodes = TestList [testForallNodesExample, testForallOneExample, testForallFiveExample, testForallSevenExample]
testForallNodesExample = TestCase $ assertEqual
                         ("forallNodes long three is ") False
                         (forallNodes long three)

testForallOneExample = TestCase $ assertEqual
                         ("forallNodes (== \"one\") one is ") True
                         (forallNodes (== "one") one)

testForallFiveExample = TestCase $ assertEqual
                         ("forallNodes (== \"one\") five is ") False
                         (forallNodes (== "one") five)

testForallSevenExample = TestCase $ assertEqual
                         ("forallNodes (\\x -> length x > 1) seven is ") True
                         (forallNodes (\x -> length x > 1) seven)

testExistsNode = TestList [testExistsNodeExample, testExistsFiveExample, testExistsOneExample, testExistsThreeExample]
testExistsNodeExample = TestCase $ assertEqual
                        ("existsNode long three is ") True
                        (existsNode long three)

testExistsFiveExample = TestCase $ assertEqual
                        ("existsNode (\\x -> length x > 1) five is ") True
                        (existsNode (\x -> length x > 1) five)

testExistsOneExample = TestCase $ assertEqual
                        ("existsNode (\\x -> length x <= 1) one is ") False
                        (existsNode (\x -> length x <= 1) one)

testExistsThreeExample = TestCase $ assertEqual
                        ("existsNode (const False) three is ") False
                        (existsNode (const False) three)

testInorder = TestList [testInorderExample, testInorderOneExample, testInorderFiveExample]
testInorderExample = TestCase $ assertEqual
                     ("inroder three is ") ["two","one","three"]
                     (inorder three)
testInorderOneExample = TestCase $ assertEqual
                     ("inroder one is ") ["one"]
                     (inorder one)

testInorderFiveExample = TestCase $ assertEqual
                     ("inroder one is ") ["two", "one", "four", "three", "five"]
                     (inorder five)

testcountNodes' = TestList [testCount'ThreeExample, testCount'OneExample, testCount'FiveExample, testCount'SevenExample]
testCount'ThreeExample = TestCase $ assertEqual
                        ("countNodes' three is ") 3
                        (countNodes' three)
testCount'OneExample = TestCase $ assertEqual
                        ("countNodes' one is ") 1
                        (countNodes' one)

testCount'FiveExample = TestCase $ assertEqual
                        ("countNodes' five is ") 5
                        (countNodes' five)

testCount'SevenExample = TestCase $ assertEqual
                        ("countNodes' seven is ") 7
                        (countNodes' seven)

testforallNodes' = TestList [testforallNodes'Example, testForall'OneExample, testForall'FiveExample, testForall'SevenExample]
testforallNodes'Example = TestCase $ assertEqual
                         ("forallNodes' long three is ") False
                         (forallNodes' long three)

testForall'OneExample = TestCase $ assertEqual
                         ("forallNodes' (== \"one\") one is ") True
                         (forallNodes' (== "one") one)

testForall'FiveExample = TestCase $ assertEqual
                         ("forallNodes' (== \"one\") five is ") False
                         (forallNodes' (== "one") five)

testForall'SevenExample = TestCase $ assertEqual
                         ("forallNodes' (\\x -> length x > 1) seven is ") True
                         (forallNodes' (\x -> length x > 1) seven)

testexistsNode' = TestList [testexistsNode'Example, testExists'FiveExample, testExists'OneExample, testExists'ThreeExample]
testexistsNode'Example = TestCase $ assertEqual
                        ("existsNode' long three is ") True
                        (existsNode' long three)

testExists'FiveExample = TestCase $ assertEqual
                        ("existsNode' (\\x -> length x > 1) five is ") True
                        (existsNode' (\x -> length x > 1) five)

testExists'OneExample = TestCase $ assertEqual
                        ("existsNode' (\\x -> length x <= 1) one is ") False
                        (existsNode' (\x -> length x <= 1) one)

testExists'ThreeExample = TestCase $ assertEqual
                        ("existsNode' (const False) three is ") False
                        (existsNode' (const False) three)

testinorder' = TestList [testinorder'Example, testinorder'OneExample, testinorder'FiveExample]
testinorder'Example = TestCase $ assertEqual
                     ("inroder' three is ") ["two","one","three"]
                     (inorder' three)
testinorder'OneExample = TestCase $ assertEqual
                     ("inroder' one is ") ["one"]
                     (inorder' one)

testinorder'FiveExample = TestCase $ assertEqual
                     ("inroder' one is ") ["two", "one", "four", "three", "five"]
                     (inorder' five)

tests = TestList [testCountNodes,testForallNodes,testExistsNode,testInorder,testcountNodes',testforallNodes',testexistsNode',testinorder']

main = runTestTT tests

