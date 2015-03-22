#read data files
NEI <-readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subset the data
baltimore_data <- NEI[which(NEI$fips == "24510"),]
baltimore_pm25_data <- ddply(baltimore_data, .(year,type), function(x) sum(x$Emissions))
colnames(baltimore_pm25_data)[3] <- "Emissions"

#plot the graph
png("plot3.png")
library(ggplot2)
library(plyr)
qplot(year, Emissions, data= baltimore_pm25_data, color= type, geom="line") + xlab("year") + ylab("PM2.5 emissions")+ ggtitle("Baltimore PM2.5 emission by type & year") 
dev.off()
