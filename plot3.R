#Q:Of the four types of sources indicated by the "type" 
#(point, nonpoint, onroad, nonroad) variable, which of 
#these four sources have seen decreases in emissions 
#from 1999-2008 for Baltimore City? Which have seen increases
#in emissions from 1999-2008? Use the ggplot2 plotting system 
#to make a plot answer this question.


#downloading & unzipping the data
Url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(Url, destfile = "DFPA.zip")
unzip("DFPA.zip")

#loading the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds") 

#preparing the data
library(tidyverse)

nei_maryland_emissions <- 
  NEI %>% 
  select(Emissions, year, fips, type) %>% 
  filter(fips == 24510) %>%  
  group_by(type, year) %>% 
  summarise(total = sum(Emissions))

#Ploting with qplot()
qplot(year, total, data = nei_maryland_emissions, col = type, geom = "line")

#ploting with ggplot() and the same result
ggplot(nei_maryland_emissions) +
  geom_line(aes(year, total, col = type))

#creating the png file
dev.copy(png, file = "plot3.png")
dev.off()
