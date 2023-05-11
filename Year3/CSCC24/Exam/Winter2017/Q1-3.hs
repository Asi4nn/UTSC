-- Part 3
nats x = x : nats (x + 1)

isPrime x = null [n | n <- [2..(x-1)], x `mod` n == 0]

primes = [n | n <- nats 2, isPrime n]

-- Part 5
myOr :: Bool -> Bool -> Bool
myOr a b = a || b

partialOr = myOr False