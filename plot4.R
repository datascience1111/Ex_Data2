rm(list = ls())

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

CoalSubset <- SCC[grep("[Cc]oal", SCC$EI.Sector), ]
NEI_CoalSubset <- merge(NEI, CoalSubset, by="SCC")

Emissions_Sum <- aggregate(Emissions ~ year, NEI_CoalSubset, sum)
r <- barplot(Emissions_Sum[,2]/1000, names.arg = Emissions_Sum[,1], ylab = "Emissions (thousands of tons)", xlab = "Year", main = "U.S. Coal Combustion Related Emissions between 1999 to 2008", col = rainbow(20), ylim = c(0,600))
text(r, 0, labels = round(Emissions_Sum$Emissions/1000, 0), cex = 1,pos = 3)

dev.copy(png, file = 'plot4.png', width = 640, height = 480, units = 'px')
dev.off() 
