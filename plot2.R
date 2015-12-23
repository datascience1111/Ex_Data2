rm(list = ls())

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


bal_emission <- NEI[which(NEI$fips == 24510), ]
Emissions_Sum <- aggregate(Emissions ~ year, bal_emission, sum)
r <- barplot(Emissions_Sum[, 2], names.arg = Emissions_Sum[, 1], ylab = "Amount of PM2.5 emitted (tons)", xlab = "Year", main = "Baltimore PM2.5 Emissions between 1999 to 2008", col = c("red", "green"), ylim = c(0,3500))
text(r, 0, labels = round(Emissions_Sum$Emissions, 0), cex = 1,pos = 3)

dev.copy(png, file = 'plot2.png', width = 640, height = 480, units = 'px')
dev.off()