# "Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question."......

NEI <- readRDS("summarySCC_PM25.rds")

emissionsAndYearsBaltimore <- NEI[!is.na(NEI$year) & NEI$fips == '24510', c("Emissions", "year")]
emissionsAndYearsBaltimore[,c("Emissions")] <- as.numeric(emissionsAndYearsBaltimore[,c("Emissions")])
emissionsAndYearsBaltimore[,c("year")] <- as.numeric(emissionsAndYearsBaltimore[,c("year")])

year <- factor(emissionsAndYearsBaltimore$year)

sumsByYear <- aggregate(x = emissionsAndYearsBaltimore, by = list(year), FUN = sum)
sumsByYear[,c("Group.1")] <- as.numeric(levels(sumsByYear$Group.1))

png(filename = 'plot2.png')
plot(x = sumsByYear$Group.1, y = sumsByYear$Emissions, type = "b", ylab = 'PM2.5 Emissions (Tons)', xlab = 'Year', main = "Baltimore City Total Emissions")
dev.off()
