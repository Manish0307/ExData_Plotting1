download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","household_power_consumption.zip")
zipfile<- unzip("household_power_consumption.zip")

a<- read.table(zipfile[1],sep=";", skip=1,colClasses="character")
names(a)<- c("Date","Time","Global_Active_power","Global_Reactive_power","Voltage","Global_Intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
a$datetime<- paste(a$Date,a$Time)

a$Date<- as.Date(a$Date,"%d/%m/%Y")

b<- a[a$Date=="2007-02-01"|a$Date=="2007-02-02",]
b$Sub_metering_1<- as.numeric(b$Sub_metering_1)  
b$Sub_metering_2<- as.numeric(b$Sub_metering_2) 
b$Sub_metering_3<- as.numeric(b$Sub_metering_3) 

b$datetime<- strptime(b$datetime, "%d/%m/%Y %H:%M:%S")

png("plot3.png",width = 480, height = 480)
plot(b$datetime,b$Sub_metering_1, type="l",xlab="",ylab="Energy Sub Metering", col="black")
lines(b$datetime,b$Sub_metering_2, type="l",xlab="",ylab="Energy Sub Metering", col="red")
lines(b$datetime,b$Sub_metering_3, type="l",xlab="",ylab="Energy Sub Metering", col="blue")
legend('topright',legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty='solid')
dev.off()
