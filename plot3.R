## "Of the four types of sources indicated by the type (point, nonpoint,onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question."

library(plyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
head(NEI)
emissionsAndYearsBaltimore <- NEI[!is.na(NEI$year) & NEI$fips == '24510', c("Emissions", "year", "type")]
emissionsAndYearsBaltimore[,c("Emissions")] <- as.numeric(emissionsAndYearsBaltimore[,c("Emissions")])
emissionsAndYearsBaltimore[,c("year")] <- as.numeric(emissionsAndYearsBaltimore[,c("year")])

aggregated <- ddply(emissionsAndYearsBaltimore, .(year, type), summarise, sum = sum(Emissions))

png(filename = 'plot3.png')
p <- qplot(aggregated$year, aggregated$sum, xlab = "Year", ylab = "PM2.5 Emissions (Tons)", main = "Baltimore City Emissions", colour = aggregated$type, geom = c("line", "point")) + scale_color_brewer(palette = "Set1", name = "Type")
print(p)
dev.off()
