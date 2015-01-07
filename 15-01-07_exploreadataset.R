url <- "https://raw.githubusercontent.com/STAT540-UBC/STAT540-UBC.github.io/master/examples/photoRec/data/GSE4051_MINI.txt"
prDat <- read.table(file = url, header = T, row.names = 1)
write.table(prDat, "photoRec.txt")
str(prDat)

#how many rows are there?
nrow(prDat)
dim(prDat)

#how many columns are there?
ncol(prDat)

#look at the data
head(prDat)

#it looks like rows respond to biogical samples i.e. mice, not genes
#I would guess the variable called CrabHammer, EggBomb, and poisonFang are genes

#What are the variable names?
names(prDat)
dimnames(prDat)

#What 'flavour' is each variable?
str(prDat)

##Take a quick look at the 'sample' column, to make sure each number appears exactly once
length(prDat$sample)
ideal <- 1:nrow(prDat)
sampnum <- as.numeric(prDat$sample)
sampnum <- sort(sampnum)
all.equal(ideal, sampnum)
#Not efficient, but good enough

#For each factor variable, what are the levels? 
levels(prDat$sample)
#Why does that return null?
?levels
levels(prDat$devStage)
lapply(prDat, levels)
#it seems levels does not apply to numeric factors

#How many observations to we have for each level of two factors?
summary(prDat$devStage)
summary(prDat$gType)

#Cross-tabulate those two factors
table(prDat$devStage, prDat$gType)
#It looks like they wanted four samples for each genotype and each developmental stage
#At some point, they lost one sample of the non-wt (mutant?) genotype at stage E16
#I wonder what is in that space in the dataset

#Make a subset of the numeric variables
subnum <- prDat[sapply(prDat, is.numeric)]

#explore the quantitative variables
sapply(subnum, summary)


##Indexing and subsetting
#Create a subset where poisonFang expression is >7.5
weeDat <- subset(prDat, poisonFang > 7.5)

#How many rows in our new data set?
nrow(weeDat)

#How do they break down by genotype?
summary(weeDat$gType)
#Four mutant, 5 wt

#By developmental stage?
levels(prDat$devStage)
summary(weeDat$devStage)
#No observations at 4 weeks or E16 match our criteria, and only one at p6.

#Show the gene expression values for samples 16 and 36
#I'll use the numeric subset I created earlier
subset(subnum, sample == c(16, 36))

#Which samples have eggBomb expression less than the 0.1 quantile
eggquant <- quantile(prDat$eggBomb, probs = 0.1)
names(eggquant) <- NULL

(weeegg <- subset(prDat, eggBomb < eggquant))
weeegg$sample


##Bonus: do the indexing and subsetting using dplyr
library(plyr)
suppressMessages(library(dplyr))

#subset of samples where poisonfang expression is >7.5
weeDat2 <- prDat %>%
  filter(poisonFang > 7.5)

#Show gene expression data for 16 and 36

prDat %>%
  select(-devStage, -gType) %>%
  filter(sample == c(16, 36))

#Which samples have eggBomb expression less than the 0.1 quantile

prDat %>%
  filter(eggBomb < eggquant)
