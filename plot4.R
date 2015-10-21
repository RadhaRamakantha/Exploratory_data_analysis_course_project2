# "Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?"

library(plyr)
library(ggplot2)
library(data.table)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

neis <- NEI[!is.na(NEI$year), c("Emissions", "year", "SCC")]
sccs <- SCC[, c("SCC", "Short.Name")]

neisTable <- data.table(neis)
sccsTable <- data.table(sccs, key="SCC")

merged <- merge(neisTable, sccsTable, by = "SCC")
coalBased <- merged[grepl(".*Coal.*", merged$Short.Name),]

aggregated <- ddply(coalBased, .(year), summarise, sum = sum(Emissions))

png(filename = 'plot4.png')
p <- qplot(aggregated$year, aggregated$sum, xlab = "Year", ylab = "PM2.5 Emissions (Tons)", main = "United States Coal Based Emissions", colour = aggregated$type, geom = c("line", "point"))
print(p)
dev.off() 
