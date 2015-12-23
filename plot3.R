rm(list = ls())
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

bal_emission <- NEI[which(NEI$fips == 24510), ]
bal_emission <- bal_emission[, 4:6]
bal_emission <- aggregate(Emissions ~ year + type, bal_emission, sum)


p <- ggplot(bal_emission, aes(x = year, y = Emissions, color = type, xlab = "Year", ylab = "Total Emissions"))
p <- p + geom_line(aes(color = type))
p <- p + ggtitle("Total Baltimore PM2.5 Emissions by Type")
p <- p + theme_bw()
print(p)

dev.copy(png, file = 'plot3.png', width = 640, height = 480, units = 'px')
dev.off() 
