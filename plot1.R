#read the file
NEI <-readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#get the subset data
pm25_annual <- tapply(NEI$Emissions, NEI$year, sum)

#plot the graph
png("plot1.png")
plot( names(pm25_annual), pm25_annual, type ="l", xlab="year", ylab="PM2.5 emissions", xlim= c(1999,2008), main="PM2.5 emissions by year", col="red")
 
dev.off()
