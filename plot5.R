rm(list = ls())

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

bal_emission <- NEI[which(NEI$fips == 24510), ]
Veh_Subset <- SCC[grep("[Vv]ehicles", SCC$EI.Sector), ]
bal_emission_Veh_Subset <- merge(bal_emission, Veh_Subset, by = "SCC")
Emissions_Sum <- aggregate(Emissions ~ year, bal_emission_Veh_Subset, sum)

r <- barplot(Emissions_Sum[,2], names.arg = Emissions_Sum[,1], ylab = "Emissions (PM2.5 amount, tons)", xlab = "Year", main = "Baltimore Vehicular Related Emissions between 1999 to 2008", col = rainbow(20), ylim = c(0,400))
text(r, 0, labels = round(Emissions_Sum$Emissions, 0), cex = 1,pos = 3)

dev.copy(png, file = 'plot5.png', width = 640, height = 480, units = 'px')
dev.off()