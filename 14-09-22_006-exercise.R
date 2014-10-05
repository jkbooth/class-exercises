#' first, load the ggplot2 library and the data we will use
library(ggplot2)
library(ggthemes)
library(RColorBrewer)
gDat <- read.delim("gapminderDataFiveYear.txt")
str(gDat)

p <- ggplot(gDat, aes(x = gdpPercap, y = lifeExp))
#initializes data for ggplot

p + geom_point()
p + layer(geom = "point")

ggplot(gDat, aes(x = log10(gdpPercap), y = lifeExp)) + geom_point()
#OR
p + geom_point() + scale_x_log10()
#Much more elegant!!

#scaling is the transformation between the units of the data and the units the computer
#stores it in

p <- p + scale_x_log10()
#we like this transformation, so we store it as part of the object
#that way we don't need to type it anymore

p <- p + geom_point(aes(color = continent))
#colours points according to the variable stored in "continent"
#also gives you a legend by default

p <- p + geom_point(alpha = (1/20), size = 2)
#alpha specifies opacity. 

#MAPPING an aesthetic is what we do when we say 'x = gdpPercap' Happens inside aes()
#SETTING an aesthetic is when we specify settings for the entire plot

p + geom_smooth(se = F, method = "lm", lwd = 2)
#lm is a linear model. lwd is line weight. by default, it gives you a grey standard error around the line

p + geom_smooth(se = F, method = "loess", lwd = 2)

p + geom_smooth(se = F, method = "lm") + facet_wrap(~ year)


##start in about strip plots
ggplot(gDat, aes(x = continent, y = lifeExp)) + geom_point()
#get that by using a scatterplot with categorical x axis

ggplot(gDat, aes(x = continent, y = lifeExp)) + geom_jitter()
#spreads it out

ggplot(gDat, aes(x = continent, y = lifeExp, color = year)) +
  geom_jitter(position = position_jitter(width = 0.1, height = 0), alpha = 1/2)

p2 <- ggplot(gDat, aes(x = continent, y = lifeExp, color = year)) +
  geom_jitter(position = position_jitter(width = 0.1, height = 0), alpha = 1/2)


p2 + geom_boxplot(alpha = 1/10) +
  stat_summary(fun.y = mean, geom = "point", colour = "green")
#overlays boxplot with a dot on the mean. NOTE stat_summary defaults to a geom line

p2a <- p2 + geom_boxplot(alpha = 1/10) +
  stat_summary(fun.y = mean, geom = "point", colour = "green")

#reorder the x axis based on life expectency

p2 <- ggplot(gDat, aes(reorder(x = continent, lifeExp), y = lifeExp, color = year)) +
  geom_jitter(position = position_jitter(width = 0.1, height = 0), alpha = 1/2)
p2
p2a <- p2 + geom_boxplot(alpha = 1/10, outlier.colour = "gray") +
  stat_summary(fun.y = mean, geom = "point", colour = "red")
p2a


#colours and subsetting

jCountries <- c("Canada", "Rwanda", "Cambodia", "Mexico")
x <- droplevels(subset(gDat, country %in% jCountries))
ggplot(x, aes(x = year, y = lifeExp, colour = country)) +
  geom_line() + geom_point()

#reorder the countries to reflect life expectency in 2007
x <- transform(x, country = reorder(country, -1*lifeExp, max))
str(x)
?droplevels
#droplevels drops unused levels from a factor or unused factors from a data frame

ggplot(x, aes(x = year, y = lifeExp, colour = country)) +
  geom_line() + geom_point() + theme_bw()

#RBREWER COLOUR PALLETS
display.brewer.all()
display.brewer.all(type = "qual")

jColour <- brewer.pal(n = 9, "Set1")[seq_len(nlevels(x$country))]
names(jColours) <- levels(x$country)

#remake the plot with the new colours
ggplot(x, aes(x = year, y = lifeExp, colour = country)) +
  geom_line() + geom_point() + theme_bw() + scale_color_manual(values = jColours)


#BAR CHARTS
table(gDat$continent)

ggplot(gDat, aes(x = continent)) + geom_bar()
p3 <- ggplot(gDat, aes(x = reorder(continent, continent, length)))
p3 + geom_bar()
#you can flip the axes like so, and by the way change the bar size
p3 + geom_bar(width = 0.5) + coord_flip()

(jDat <- as.data.frame(with(gDat, table(continent, deparse.level = 2))))
?deparse
str(gDat$continent[2])
gDat$continent
#
ggplot(jDat, aes(x = continent)) + geom_bar()
#no longer works, because we have pre-tabulated continent data
ggplot(jDat, aes(x = continent, y = Freq)) + geom_bar(stat = "identity")
