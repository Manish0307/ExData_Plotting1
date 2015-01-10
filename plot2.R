download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","household_power_consumption.zip")
zipfile<- unzip("household_power_consumption.zip")

a<- read.table(zipfile[1],sep=";", skip=1,colClasses="character")
names(a)<- c("Date","Time","Global_Active_power","Global_Reactive_power","Voltage","Global_Intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
a$datetime<- paste(a$Date,a$Time)

a$Date<- as.Date(a$Date,"%d/%m/%Y")

b<- a[a$Date=="2007-02-01"|a$Date=="2007-02-02",]
b$Global_Active_power<-as.numeric(b$Global_Active_power)

b$datetime<- strptime(b$datetime, "%d/%m/%Y %H:%M:%S")

png("plot2.png",width = 480, height = 480)
with(b,plot(datetime,Global_Active_power,ylab="Global Active Power(kilowatts)",xlab="",type="l"))
dev.off()

