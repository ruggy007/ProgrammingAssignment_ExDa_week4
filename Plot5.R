fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileurl,destfile=paste0(getwd(),"/NEI_data.zip"),method = "curl")
unzip("NEI_data.zip",exdir="./")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

gl<-grepl("(.*)(Highway Veh)(.*)",SCC$Short.Name)
SCC_MotorVeh<-SCC[gl,]
NEI_Baltimore_MotorVeh<-subset(NEI_Baltimore, SCC %in% SCC_MotorVeh$SCC)
NEI_Baltimore_MotorVeh_year<-tapply(NEI_Baltimore_MotorVeh$Emissions, 
                                    NEI_Baltimore_MotorVeh$year, sum, na.rm=TRUE)

##png("plot5.png", width=640, height=480)
par(mfrow=c(1,1),mar=c(5,5,4,2))
barplot(NEI_Baltimore_MotorVeh_year, names.arg = names(NEI_Baltimore_MotorVeh_year), col="darkorchid2", 
        main="Emissions of PM2.5 from motor vehicles by year in Baltimore City", 
        xlab = "Year", ylab="Amount of emissions (tons)", 
        ylim = range(0,NEI_Baltimore_MotorVeh_year)*1.1)