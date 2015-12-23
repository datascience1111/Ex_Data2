rm(list = ls())

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

Emissions_Sum <- aggregate(Emissions ~ year, NEI, sum)
r <- barplot(Emissions_Sum[,2]/1000, names.arg = Emissions_Sum[,1], ylab = "Amount of PM2.5 emitted (thousands of tons)", xlab = "Year", main = "U.S. PM2.5 Emissions between 1999 to 2008", col = c("red", "blue", "yellow", "green"), ylim = c(0,7500))
text(r, 0, labels = round(Emissions_Sum$Emissions, 0), cex = 1,pos = 3)

dev.copy(png, file = 'plot1.png', width = 640, height = 480, units = 'px')
dev.off()

