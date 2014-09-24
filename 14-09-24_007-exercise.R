library(dplyr)
library(ggplot2)

gdf <- read.delim("gapminderDataFiveYear.txt")
str(gdf)
head(gdf)

#put it an a tbl_df, an upgraded data.frame
gtbl <- tbl_df(gdf)
str(gtbl)
gtbl
