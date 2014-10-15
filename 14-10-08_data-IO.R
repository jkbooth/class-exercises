source("gapminderstartup.R")
##Often, you will have to create rectangular data that will be exported from R
##We will probably need to use multiple scripts
##Today's outputs are tomorrow's inputs

#subset the data, just to make it easier

sub <- c("France", "Haiti", "Rwanda", "Canada", "Cambodia")
sDat <- gDat %>%
  filter(country %in% sub) %>%
  droplevels

dim(sDat)
names(sDat)
sDat$country

#Pretent this was the output we wanted for our next analysis
write.table(x = sDat, file = "sDat.txt")
#It exports it with row names as integers converted to character, and with strings in quotes

write.table(x = sDat, file = "sDat2.csv", sep = ",", quote = F, row.names = F)
#That's better

write.table(x = sDat, file = "sDat3.tsv", sep = "\t", quote = F, row.names = F)
#Or that

##you can also save in an R-native binary format that will preserve more data

levels(sDat$country)
rDat <- sDat %>%
  mutate(country = reorder(country, lifeExp, max))
rDat

c(levels(sDat$country), levels(rDat$country))

write.csv(rDat, "rDat.csv")
rm(rDat)
rDat <- read.csv("rDat.csv")
levels(rDat$country)
##They went back to alphabetical when I loaded it again

##write to file with saveRDS(). You can save ANY R OBJECT this way
rDat <- sDat %>%
  mutate(country = reorder(country, lifeExp, max))
saveRDS(rDat, "rDat.rds")
rm(rDat)
rDat <- readRDS("rDat.rds")
levels(rDat$country)

dput(rDat, "rDat-dput.txt")
##plain-text r representation of file

rm(rDat)
rDat <- dget("rDat-dput.txt")
levels(rDat$country)

pDat <- 