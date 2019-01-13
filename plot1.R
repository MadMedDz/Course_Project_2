#Q: Have total emissions from PM2.5 decreased in the United States
#from 1999 to 2008? Using the base plotting system, make a plot 
#showing the total PM2.5 emission from all sources for each of 
#the years 1999, 2002, 2005, and 2008.

Url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(Url, destfile = "DFPA.zip")
unzip("DFPA.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds") 

#the total of PM2.5 emission for each year
emission.year <- aggregate(NEI$Emissions, list(year = NEI$year), sum)

#total PM2.5 emission for each year plot
with(emission.year, 
     plot(
       year, x, 
          type = "l",
          main = "total PM2.5 emission throught the years", 
          xlab = "years", 
          ylab = "PM2.5"
          )
      )

dev.copy(png, file = "plot1.png")
dev.off()

     