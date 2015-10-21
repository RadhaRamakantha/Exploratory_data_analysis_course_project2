# "Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?".......

library(plyr)
library(ggplot2)
library(data.table)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

neis <- NEI[!is.na(NEI$year) & (NEI$fips == '24510' | NEI$fips == '06037'), c("Emissions", "year", "SCC", "fips")]
sccs <- SCC[, c("SCC", "Short.Name")]

neisTable <- data.table(neis)
sccsTable <- data.table(sccs, key="SCC")

merged <- merge(neisTable, sccsTable, by = "SCC")
cars <- merged[grepl("Highway Veh.*", merged$Short.Name),]
cars$fips[cars$fips == '24510'] <-'Baltimore City'
cars$fips[cars$fips == '06037'] <-'Los Angeles County, California'

aggregated <- ddply(cars, .(year, fips), summarise, sum = sum(Emissions))

png(filename = 'plot6.png')
p <- qplot(aggregated$year, aggregated$sum, xlab = "Year", ylab = "PM2.5 Emissions (Tons)", main = "Comparison of Motor Vehicle Emissions", colour = aggregated$fips, geom = c("line", "point")) + scale_color_brewer(palette = "Set1", name = "Location")
print(p)
dev.off()
