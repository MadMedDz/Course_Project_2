Url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(Url, destfile = "DFPA.zip")
unzip("DFPA.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds") 

library(dplyr)

nei_maryland_emissions <- 
  NEI %>% 
  select(Emissions, year, fips) %>% 
  filter(fips == 24510) %>%  
  group_by(year) %>% 
  summarise(total = sum(Emissions))

with(
  nei_maryland_emissions, 
     plot(
       year, total, 
       type = "l",
       main = "total PM2.5 emission in the Baltimore City throught the years", 
       xlab = "years", 
       ylab = "PM2.5"
     )
)

dev.copy(png, file = "plot2.png")
dev.off()
