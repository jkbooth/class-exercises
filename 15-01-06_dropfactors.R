gDat <- read.delim("gapminderDataFiveYear.txt")
library(psych)
library(dplyr)

#try to keep only the factors that are numeric
lapply(gDat, class)
temp <- gDat[sapply(gDat, is.numeric)]
str(temp)
gDat2 <- temp

filter
#from the psych package
describe(gDat2)
#do a correlation between each factor
cor(gDat2)
