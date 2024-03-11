fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileurl,destfile=paste0(getwd(),"/NEI_data.zip"),method = "curl")
unzip("NEI_data.zip",exdir="./")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

total_year<-tapply(NEI$Emissions, NEI$year, sum, na.rm=TRUE)
##png("plot1.png", width=640, height=640)
par(mfrow=c(1,1),mar=c(5,5,4,2))
barplot(total_year/1000, names.arg = names(total_year), col="dodgerblue2", main="Emissions of PM2.5 by year", 
        xlab = "Year", ylab="Amount of emissions (kilotons)", ylim = range(0,total_year/1000) * 1.1)
lines(names(total_year), total_year/1000, lwd=2, col="blue")