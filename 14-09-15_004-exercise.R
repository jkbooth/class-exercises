#LEARNING ALL ABOUT DATA AND DATA FRAMES

#to retrieve data from the internet, one way is to save the webpage as a text file
list.files()

#Can also save data to an object
#gdURL <- "http://url.com"
#gDAT <- read.delim(file = gdURL)
gDat <- read.delim("gapminderDataFiveYear.txt")

str(gDat)
#country is a factor with 142 levels, meaning 142 unique contries
#year is an integer

head(gDat)
tail(gDat)
#lets you inspect first and last rows of data frame

names(gDat)
#shows us variable names, ie column names
dim(gDat)
#gives us the dimensions of the dataframe. Can be stored as a variable
length(gDat)
#gives you the number of VARIABLES as the length of the dataframe

summary(gDat)
#for each variable, makes some summary

subset(gDat, country == "Luxembourg")
plot(lifeExp ~ year, gDat)
plot(lifeExp ~ gdpPercap, gDat)
plot(lifeExp ~ log(gdpPercap), gDat)

gDat$lifeExp
# $ symbol specifies variable within object
summary(gDat$lifeExp)
str(gDat$lifeExp)

hist(gDat$lifeExp)
#makes a histogram

gDat$continent
class(gDat$continent)
#tells you that continent is a  FACTOR, which stores categorical information
str(gDat$continent)
#shows you that levels of a factor are actually being stored as positive integers

levels(gDat$country)
#shows you all the levels of a factor
nlevels(gDat$country)
#tells you how many levels there are of a factor
table(gDat$continent)
barplot(table(gDat$continent))
#gives you a barplot of a table of the continents

dotchart(table(gDat$continent))

library(ggplot2)
install.packages("ggplot2")

p <- ggplot(gDat, aes(x = gdpPercap, y = lifeExp))
p <- ggplot(subset(gDat, year == 2007),
            aes(x = gdpPercap, y = lifeExp))
p <- p + scale_x_log10()
p + geom_point()
#using ggplot to make nicer looking graphs

p + geom_point(aes(color = continent))
#maps continent to color

p + geom_point(alpha = (1/3), size = 3)
p + geom_point() + geom_smooth(lwd = 3, se = FALSE)
#geom_point creates scatter plots, geom_smooth adds a smoothed conditional mean line

p + aes(color = continent) + geom_point() + geom_smooth(lwd = 3, se = FALSE)

p + geom_point(alpha = (1/3), size = 3) + facet_wrap(~ continent)

subset(gDat, subset = country == "Uruguay")
gDat[1621:1632, ]
#BOTH return the subset of dataframe gDat for the variable country where country is Uruguay (CASE SENSITIVE)
#subset is better because it is robust to changes in the data, and not intelligible to the reader

subset(gDat, subset = country == "Mexico",
       select = c(country, year, lifeExp))

q <- ggplot(subset(gDat, country == "Colombia"), aes(x = year, y = lifeExp))
q + geom_point() + geom_smooth(lwd = 1, se = FALSE, method = "lm")

str(q)
#it initially returned a blank plot, so I used str to examine q. it turned out I had spelled Colombia wrong

(minYear <- min(gDat$year))
str(minYear)
#minYear is an integer

myFit <- lm(formula = lifeExp ~ I(year - minYear), gDat, subset = country == "Colombia")
summary(myFit)
#lm is used to fit linear models
#summary gives the call, certain statistical parameters for the linear model

str(myFit)
#complicated!
names(myFit)
length(myFit)
dim(myFit)
dim(gDat)

subset(gDat, country == "Canada")
#ok, so it includes canada

lm(lifeExp ~ year, gDat, subset = country == "Canada")
plot(lifeExp ~ year, gDat, subset = country == "Canada")

cor(gDat$lifeExp, gDat$gdpPercap)
#returns correlation between two vectors, in this case life expectency and gdp per capita
with(subset(gDat, subset = country == "Canada"),
     cor(lifeExp, gdpPercap))
#returns the correlation between life expectency and gdp in the specific country canada