gDat <- read.delim("gapminderDataFiveYear.txt")
source("gapminderstartup.R")
str(gDat)
library(plyr)


le_lin_fit <- function(dat, offset = 1952) {
  the_fit <- lm(lifeExp ~ I(year - offset), dat)
  setNames(coef(the_fit), c("intercept", "slope"))
}

j_coefs <- ddply(gDat, ~ country + continent, le_lin_fit)
str(j_coefs)

class(j_coefs$country)

ggplot(j_coefs, aes(x = slope, y = country)) + geom_point(size = 3)

#reorder to make it easier to see
ggplot(j_coefs, aes(x = slope, y = reorder(country, slope), colour = continent)) + 
  geom_point(size = 3) + theme_bw()

#dropping unused factor levels
# we'll focus on 5 countries
h_countries <- c("Egypt", "Haiti", "Romania", "Thailand", "Venezuela")
h_dat <- gDat %>%
  filter(country %in% h_countries)
h_dat
str(h_dat)
table(h_dat$country)
levels(h_dat$country)
##note that! the factors for the other countries that we dropped are  STILL THERE

iDat <- droplevels(h_dat)
str(h_dat)
levels(iDat$country)

#OR

iDat <- h_dat %>%
  droplevels

##get a new df with the max life expectency for each country in iDat

(maxlf <- iDat %>%
  group_by(country) %>%
  summarize(max_life = max(lifeExp)))

ggplot(maxlf, aes(x = country, y = max_life, group = 1)) + geom_path() + geom_point(size = 3)
#grouping lets you connect the dots
ggplot(iDat, aes(x = year, y = lifeExp, group = country)) + geom_line(aes(colour = country))

#let's talk about reorder
#reorder(factor, quant_var, summarizationfunction)
#summarization function defaults to mean
ggplot(maxlf, aes(x = country, y = max_life, group = 1)) + geom_path() + geom_point(size = 3)

jDat <- iDat %>%
  mutate(country = reorder(country, lifeExp, max))
data.frame(before = levels(iDat$country),
           after = levels(jDat$country))

(maxlf2 <- jDat %>%
   group_by(country) %>%
   summarize(max_life = max(lifeExp)))
ggplot(maxlf2, aes(x = country, y = max_life, group = 1)) + geom_path() + geom_point(size = 3)
