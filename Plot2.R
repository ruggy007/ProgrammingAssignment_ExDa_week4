fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileurl,destfile=paste0(getwd(),"/NEI_data.zip"),method = "curl")
unzip("NEI_data.zip",exdir="./")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI_Baltimore<-subset(NEI, fips == "24510")
Baltimore_year<-tapply(NEI_Baltimore$Emissions, NEI_Baltimore$year, sum, na.rm=TRUE)

##png("plot2.png", width=640, height=640)
par(mfrow=c(1,1),mar=c(5,5,4,2))
barplot(Baltimore_year, names.arg = names(Baltimore_year), col="dodgerblue3", 
        main="Emissions of PM2.5 by year in Baltimore City", xlab = "Year", 
        ylab="Amount of emissions (tons)", ylim = range(0,Baltimore_year)*1.1) 