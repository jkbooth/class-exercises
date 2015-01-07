#This comes from lecture 02 of GSAT540
B <- 10000
n <- 10
p <- 0.5
x <- 7
#these functions are equivalent
choose(n, x) * p^x * (1-p)^(n-x)
dbinom(x = x, size = n, prob = p)

(myGuess <- round(dbinom(x = x, size = n, prob = p)*B, 0))
(obsFreq <- sum(rbinom(n = B, size = n, prob = p) == x))
(pSad <- abs(myGuess - obsFreq)/B)

#simulate coin flips
coinFlips <- runif(n*B) > 0.5
coinFlips <- matrix(coinFlips, nrow = B)

head(coinFlips)
y <- rowSums(coinFlips)
head(y)

myGuess2 <- sum(y == 7)

(pSad2 <- abs(myGuess2 - obsFreq)/B)
