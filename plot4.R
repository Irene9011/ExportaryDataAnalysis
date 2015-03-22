#read data files
NEI <-readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

coal_combustion_data <- subset(SCC, EI.Sector %in% c("Fuel Comb - Comm/Instutional - Coal", "Fuel Comb - Electric Generation - Coal", "Fuel Comb - Industrial Boilers, ICEs - Coal"))

#get comparisons
cmprsn_data <- subset(SCC, grepl("Comb", Short.Name) & grepl("Coal", Short.Name) 
diffA <- setdiff(cmprsn_data$SCC, coal_combustion_data$SCC)
diffB <- setdiff(coal_combustion_data$SCC, cmprsn_data$SCC)
coal_comb_data_union <- union(coal_combustion_data$SCC, cmprsn_data$SCC)
 
coal_comb_data_new <- subset(NEI, SCC %in% coal_comb_data_union)

coal_comb_data_final <- ddply(coal_comb_data_new, .(year, type), function(x) sum(x$Emissions))

colnames(coal_comb_data_final)[3] <- "Emissions"

png("plot4.png")
qplot(year, Emissions, data=coal_comb_data_final, color=type, geom="line") +geom_line(aes(size="total", shape=NA)) + stat_summary(fun.y="sum", fun.ymin="sum", fun.ymax="sum", color="red", aes(shape="total"), geom="line") +xlab("year")+ ylab("PM2.5 emissoins")+ ggtitle("Coal Combustion PM2.5 emissions by type & year")+ theme_bw(base_family = "Times")
dev.off()
