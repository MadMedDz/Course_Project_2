#Q: Across the United States, how have emissions from 
#coal combustion-related sources changed from 1999-2008?

#downloading & unzipping the data
Url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(Url, destfile = "DFPA.zip")
unzip("DFPA.zip")

#loading the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds") 

#preparing the data
library(tidyverse)

nei_tbl <- as_tibble(NEI)
scc_tbl <- as_tibble(SCC)


#Finding the SSC observation where coal exist
rows.indices <-
  grepl("coal", SCC$EI.Sector, ignore.case = TRUE)

#the values of the SCC in a character vector
SCC.COAL <- as.character(SCC$SCC[rows.indices])

#subsetting the NEI dataset with the values from the SCC vector
table(NEI$SCC %in% SCC.COAL)
#Founding that there are 28480 observations that match with 
#the coal combustion related sources

coal_logi <- NEI$SCC %in% SCC.COAL

NEI_coal <- NEI %>% 
  filter(coal_logi) %>% 
  group_by(year) %>% 
  summarise(total = sum(Emissions))

#Creating the plot
ggplot(NEI_coal, aes(year,total)) +
  geom_line()

#creating the png file
dev.copy(png, filename = "plot4.png")
dev.off()
