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
