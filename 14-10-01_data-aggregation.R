#ddply!!!! (from plyr)
#takes a data.frame, divides in into data.frames based on a given variable, applies a function to all of them, and then glues them all back together

library(plyr)
library(assertthat)
library(ggplot2)
gDat <- read.delim("gapminderDataFiveYear.txt")

#challenge: write a fun:
#input: data.frame with at least 2 variables: year and life expectency
#output: numeric vector estimated intercept and slope from lm(lifeExp ~ year, data)

?lm

#start by getting it to work for just one country
my_country = "Rwanda"
my_subset <- subset(gDat, country == my_country)
plot <- ggplot(my_subset, aes(x = year, y = lifeExp))
plot + geom_point() + geom_smooth(method = "lm", se = F)
model <- lm(formula = lifeExp ~ year, my_subset)
coef(model)
regress <- function(dat, x, y) {
  lm(formula = x ~ y, data = dat)
}
assert_that(is.numeric(x, y))
regress(gDat, gDat$lifeExp, gDat$year)
