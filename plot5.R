# "How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?"

library(plyr)
library(ggplot2)
library(data.table)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

neis <- NEI[!is.na(NEI$year) & NEI$fips == '24510', c("Emissions", "year", "SCC")]
sccs <- SCC[, c("SCC", "Short.Name")]

neisTable <- data.table(neis)
sccsTable <- data.table(sccs, key="SCC")

merged <- merge(neisTable, sccsTable, by = "SCC")
cars <- merged[grepl("Highway Veh.*", merged$Short.Name),]

aggregated <- ddply(cars, .(year), summarise, sum = sum(Emissions))

png(filename = 'plot5.png')
p <- qplot(aggregated$year, aggregated$sum, xlab = "Year", ylab = "PM2.5 Emissions (Tons)", main = "Baltimore City Motor Vehicle Emissions", colour = aggregated$type, geom = c("line", "point"))
print(p)
dev.off()
