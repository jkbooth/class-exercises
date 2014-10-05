library(dplyr)
suppressMessages("dplyr")
library(ggplot2)
library(assertthat)
gDat <- read.delim("gapminderDataFiveYear.txt")
str(gDat)

##making functions!
##here's what we want to function-ize:
##input: a variable
##output: max - min

#input will be life expectency
range(gDat$lifeExp)
minlife <- min(gDat$lifeExp)
maxlife <- max(gDat$lifeExp)
str(maxlife)
maxlife - minlife
diff <- maxlife - minlife

#turn it into a function, then TEST IT
difference <- function(x) max(x) - min(x)
difference(gDat$lifeExp)

##test it on other inputs
difference(gDat$pop)
difference(gDat$gdpPercap)
difference(seq(1, 40))
difference(rnorm(1000))
difference(runif(1000))
test <- c(NA,NA,NA,NA)
difference(test)
difference(gDat$continent)
str(gDat$country)
difference(gDat$country)
difference(gDat)
a <- (1:10)
b <- (11:20)
c <- (31:40)
vect <- cbind(a, b, c)
difference(vect)
difference(gDat[c('lifeExp', 'pop', 'gdpPercap')])
difference(c(T,T,F,T))

#here's how a function usually looks
mmm <- function(x) {
  stopifnot(is.numeric(x))
  max(x) - min(x)
}
mmm(test)
mmm(gDat[c('lifeExp', 'pop', 'gdpPercap')])
mmm(vect)

#we can get a more informative error message by using if and then stop, and specifying an error message
mmm2 <- function(x) {
  if(!is.numeric(x)){
    stop('Oops, this function is reserved for numeric inputs')
  }
  max(x) - min(x)
}
mmm2(gDat)

#assertthat provides a replacement for stopifnot
mmm3 <- function(x) {
  require(assertthat)
  assert_that(is.numeric(x))
  max(x) - min(x)
}
mmm3(gDat)

#let's make our function more general
#min and max are special cases of quantiles. median is 0.5 quantile, 1st quartile is 0.25
#quartile, min is 0 quantile, max is 1 quantile
#let's make a function that gives us the difference between any two quantiles
?quantile
summary(gDat$lifeExp)
quantile(gDat$lifeExp, probs = 0)
the_probs <- c(0.25, 0.75)
quant_diff <- 
  quantile(gDat$lifeExp, probs = the_probs)
max(quant_diff) - min(quant_diff)

qdiff1 <- function(x, probs) {
  assert_that(is.numeric(x))
  quant_diff <- 
    quantile(x, probs = probs)
  max(quant_diff) - min(quant_diff)
}
qdiff1(gDat$lifeExp, probs = c(0, 1))
qdiff1(gDat$lifeExp, probs = c(0.25, 0.75))
qdiff1(gDat$lifeExp, probs = c(0.2, 0.8))

qdiff1(gDat$lifeExp)

#we can give a default by specifying it in the definition of the variables
qdiff2 <- function(x, probs = c(0,1)) {
  assert_that(is.numeric(x))
  quant_diff <- 
    quantile(x, probs = probs)
  max(quant_diff) - min(quant_diff)
}
qdiff2(gDat$lifeExp, probs = c(0.25,0.75))

#let's re-try some more validity checks
#probs should be in [0,1] and numeric
a <- 1:10
qdiff2(a, probs = "solid")
qdiff2(a)
qdiff2(a, probs = c(0.25, 0.75))
#check that probs is length 2

str(qdiff1)
str(qdiff2)

#just in case, we can make sure our output is numeric
qdiff3 <- function(x, probs = c(0,1)) {
  assert_that(is.numeric(x))
  quant_diff <- 
    quantile(x, probs = probs)
  names(quant_diff) <- NULL
  max(quant_diff) - min(quant_diff)
}
qdiff3(gDat$lifeExp)
quant_diff

##NAs: let's be proactive!

qdiff4 <- function(x, probs = c(0,1)) {
  assert_that(is.numeric(x))
  quant_diff <- 
    quantile(x, probs = probs)
  max(quant_diff) - min(quant_diff)
}

z <- gDat$lifeExp
z[3] <- NA
head(z)
quantile(z)
mean(z)
#mean function propagates NAs, because if there are any NAs, it returns NA
quantile(z, na.rm = T)
mean(z, na.rm = T)
median(z, na.rm = T)

qdiff5 <- function(x, probs = c(0,1), na.rm = T) {
  assert_that(is.numeric(x))
  quant_diff <- quantile(x, probs, na.rm)
  max(quant_diff) - min(quant_diff)
}

qdiff5(z)

##the ... argument can be used to pass arguments to other functions

library(testthat)

test_that("invalid arguments are detected", {
  expect_error(qdiff5("eggplants are purple"))
  expect_error(qdiff5(iris))
})

