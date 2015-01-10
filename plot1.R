download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","household_power_consumption.zip")
zipfile<- unzip("household_power_consumption.zip")

a<- read.table(zipfile[1],sep=";", skip=1,colClasses="character")
names(a)<- c("Date","Time","Global_Active_power","Global_Reactive_power","Voltage","Global_Intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
a$datetime<- paste(a$Date,a$Time)

a$Date<- as.Date(a$Date,"%d/%m/%Y")

b<- a[a$Date=="2007-02-01"|a$Date=="2007-02-02",]
b$Global_Active_power<-as.numeric(b$Global_Active_power)


png("plot1.png",width = 480, height = 480)
hist(b$Global_Active_power,main="Global Active Power", xlab ="Global Active Power",xlim=range(c(0,2,4,6)),ylim=range(c(0,1200)),col="red")
dev.off()
