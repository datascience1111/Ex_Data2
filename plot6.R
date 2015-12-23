rm(list = ls())
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

bal_emission <- NEI[which(NEI$fips == 24510), ]
lac_emission <- NEI[which(NEI$fips == "06067"), ]
combined_emission <- merge(bal_emission, lac_emission, all = TRUE)

Veh_Subset <- SCC[grep("[Vv]ehicles", SCC$EI.Sector), ]
combined_emission_Veh_subset <- merge(combined_emission, Veh_Subset, by = "SCC")
combined_emission_Veh_subset <- aggregate(Emissions ~ year + fips, combined_emission_Veh_subset, sum)

combined_emission_Veh_subset$fips[combined_emission_Veh_subset$fips == "06067"] <- "06067 (Los Angeles)"
combined_emission_Veh_subset$fips[combined_emission_Veh_subset$fips == "24510"] <- "24510 (Baltimore City)"

p <- ggplot(combined_emission_Veh_subset, aes(x = year, y = Emissions, color = fips, xlab= "Year", ylab = "Vehicle Emissions (tons of PM2.5)"))
p <- p + geom_line(aes(color = fips))
p <- p + ggtitle("Baltimore vs. Los Angeles Motor Vehicle Emissions from 1999-2008")
p <- p + theme_bw()
print(p)

dev.copy(png, file = 'plot6.png', width = 640, height = 480, units = 'px')
dev.off() 