#read data files
NEI <-readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subset the data
baltimore_data <- NEI[which(NEI$fips == "24510"),]
baltimore_pm25_annual <- tapply(baltimore_data$Emissions, baltimore_data$year, sum)

#plot the graph
png("plot2.png")
plot(names(baltimore_pm25_annual), baltimore_pm25_annual, type="l", xlab="year", ylab= "PM2.5 emissions", xlim=c(1999,2008), main="Baltimore PM2.5 emissions by year", col="blue")
> dev.off()
