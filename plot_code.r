#### load libraries
library(tidyr)
library(stringr)
library(ggplot2)

### import data from csv file
salmondata <- read.csv("data.csv",header = TRUE, check.names=TRUE)

## convert from wide to long format
data_long <- gather(salmondata, Year, Count, X1993:X2013)

data_long$Year <- as.numeric(substring(data_long$Year, 2))

# replace 0 with NAs
data_long[data_long ==0] = NA
colnames(data_long)[1] <- "Julian"

## plot data as is
brks <- c(1993:2013)
labs <- brks
ggplot(data_long, aes(Year, Julian, size = factor(Count))) +
  geom_point() + theme_bw() + scale_size_discrete(name="Salmon\nCount") +
  scale_x_continuous(breaks=brks,
                   labels=labs)
