# "Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002,2005, and 2008."

NEI <- readRDS("summarySCC_PM25.rds")

emissionsAndYears <- NEI[!is.na(NEI$year), c("Emissions", "year")]
emissionsAndYears[,c("Emissions")] <- as.numeric(emissionsAndYears[,c("Emissions")])
emissionsAndYears[,c("year")] <- as.numeric(emissionsAndYears[,c("year")])

year <- factor(NEI$year)

sumsByYear <- aggregate(x = emissionsAndYears, by = list(year), FUN = sum)
sumsByYear[,c("Group.1")] <- as.numeric(levels(sumsByYear$Group.1))

png(filename = 'plot1.png')
plot(x = sumsByYear$Group.1, y = sumsByYear$Emissions, type = "b", ylab = 'PM2.5 Emissions (Tons)', xlab = 'Year', main = "United States Total Emissions")
dev.off()
