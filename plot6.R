#Q:Compare emissions from motor vehicle sources in Baltimore City with 
#emissions from motor vehicle sources in Los Angeles County, 
#California (fips=="06037"). Which city has seen greater changes 
#over time in motor vehicle emissions?

#downloading & unzipping the data
Url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(Url, destfile = "DFPA.zip")
unzip("DFPA.zip")

#loading the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds") 

#preparing the data
library(tidyverse)

#we need 2 vectors for filtering the data

#For the location condition
location <- c("24510", "06037")

nei.vehicles.balt.lac <- 
  NEI %>% 
  filter(NEI$SCC %in% scc_vehicles & NEI$fips %in% location) %>% 
  group_by(fips, year) %>% 
  summarise(total = sum(Emissions))

#creating the plot

ggplot(nei.vehicles.balt.lac, aes(year, total)) +
  geom_line(aes(col = fips))

dev.copy(png, filename = "plot6.png")
dev.off()
