#Q: How have emissions from motor vehicle sources changed 
#from 1999-2008 in Baltimore City?

#downloading & unzipping the data
Url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(Url, destfile = "DFPA.zip")
unzip("DFPA.zip")

#loading the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds") 

#preparing the data
library(tidyverse)

#searching for the observations for emissions from motor vehicle
#sources in the SCC dataset
levels(SCC$EI.Sector) #to see the differents levels of the factor variable
#creating the logical victor for sebsetting
logi_vehicles <- grepl("Vehicles", SCC$EI.Sector, ignore.case = TRUE) 
#creating the vector with the values of SCC corresponding to observations of the vehicles
scc_vehicles <- as.character(SCC$SCC[logi_vehicles])

#creating the logical victor for the matching between the values of SCC in SCC and the values of SCC in NEI
nei.vehicles.balt <- 
  NEI %>% 
  filter(NEI$SCC %in% scc_vehicles & fips == "24510") %>% 
  group_by(year) %>% 
  summarise(total = sum(Emissions))

#creating the plot
ggplot(nei.vehicles.balt, aes(year,total)) +
  geom_line()

#creating the png file
dev.copy(png, filename = "plot5.png")
dev.off()
