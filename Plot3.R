fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileurl,destfile=paste0(getwd(),"/NEI_data.zip"),method = "curl")
unzip("NEI_data.zip",exdir="./")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)
library(reshape2)

Bmelt<-melt(NEI_Baltimore,id=c("year","type"), measure.vars = "Emissions")
Bcast<-dcast(Bmelt,year~type,sum)
Baltimore_type<-melt(Bcast,id=c("year"),measure.vars=names(Bcast)[-c(1)])

##png("plot3.png", width=640, height=480)
gt<-ggplot(Baltimore_type, aes(x=year,y=value)) + geom_col(width = 1,mapping=aes(fill=variable)) + 
  facet_grid(.~variable) + theme_bw() + geom_smooth(method = "lm") +
  labs(title="Emissions of PM2.5 in Baltimore City by type") +
  xlab("Year") + ylab("Amount of PM2.5 emissions (tons)")+
  theme(text= element_text(size = 10), plot.title = element_text(size=13, hjust = 0.5, face="bold"), 
        plot.margin = margin(1, 1, 1, 1, "cm"))
gt