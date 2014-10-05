#DPLYR PART 1: TBL_DF, GLIMPSE, FILTER, %>%

library(dplyr)
library(ggplot2)
suppressPackageStartupMessages(library(dplyr))
gdf <- read.delim("gapminderDataFiveYear.txt")
str(gdf)
head(gdf)

#put it an a tbl_df, an upgraded data.frame
gtbl <- tbl_df(gdf)
str(gtbl)
gtbl

#like str, but a little easier to read
glimpse(gtbl)

#make a disposable variable to inspect whatever
(snippet <- subset(gdf, country == "Canada"))

#use filter() to subset data row-wise. Same functions as subset(), but with more functions
#uses one or more logical statements, keeps the ones where all arguments return T
filter(gtbl, lifeExp < 29)
filter(gtbl, country == "Rwanda")
filter(gtbl, country %in% c("Rwanda", "Canada"))

gdf %>% head #is equivalent to
head(gdf)
#shortcut for %>% is ctrl-shift-m

gdf %>%
  head(3)

select(gtbl, year, lifeExp) #tbl_df prevents too much info from printing to the console

gtbl %>%
  select(year, lifeExp) %>%
  head(4)
gtbl %>%
  filter(country == "Cambodia") %>%
  select(year, lifeExp)

#PART 2: mutate, arrange, rename, group_by()

gtbl %>%
  glimpse
gtbl %>%
  mutate(gdp = pop*gdpPercap)
identical(gdf, gtbl)

just_canada <- gtbl %>%
  filter(country == "Canada")

gtbl <- gtbl %>%
  mutate(canada = just_canada$gdpPercap[match(year, just_canada$year)], gdpPercapRe1 = gdpPercap / canada)

gtbl %>%
  select(gdpPercapRe1) %>%
  summary

gtbl %>%
  arrange(year, country)

gtbl %>%
  filter(year == 2007) %>%
  arrange(lifeExp)

gtbl %>%
  filter(year == 2007) %>%
  arrange(desc(lifeExp))

gtbl <- gtbl %>%
  rename(life_exp = lifeExp, gdp_percap = gdpPercap, gdp_percap_re1 = gdpPercapRe1)
  
gtbl %>%
  group_by(continent) %>%
  summarize(n_obs = n())

gtbl %>%
  group_by(continent) %>%
  tally

gtbl %>%
  group_by(continent) %>%
  summarize(n_obs = n(), n_countries = n_distinct(country))

gtbl %>%
  group_by(continent, year) %>%
  summarise_each(funs(mean, median), lifeExp, gdpPercap)

gtbl %>%
  filter(continent == "Asia") %>%
  group_by(year) %>%
  summarize(min_life_exp = min(lifeExp), max_life_exp = max(lifeExp))

gtbl %>%
  filter(continent == "Asia") %>%
  group_by(year) %>%
  select(year, country, lifeExp) %>%
  filter(min_rank(desc(lifeExp))<2 | min_rank(lifeExp) < 2) %>%
  arrange(year)

gtbl %>%
  group_by(continent, country) %>%
  select(country, year, continent, lifeExp) %>%
  mutate(le_delta= lifeExp - lag(lifeExp)) %>%
  summarize(worst_le_delta = min(le_delta, na.rm = T)) %>%
  filter(min_rank(worst_le_delta) < 2) %>%
  arrange(worst_le_delta)
?lag
