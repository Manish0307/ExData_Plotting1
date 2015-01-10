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
b$Global_Active_power<-as.numeric(b$Global_Active_power)
b$Global_Reactive_power<-as.numeric(b$Global_Reactive_power)
b$Voltage<-as.numeric(b$Voltage)

b$datetime<- strptime(b$datetime, "%d/%m/%Y %H:%M:%S")

png("plot4.png",width = 480, height = 480)

par(mfrow=c(2,2))
with(b,
{
plot(datetime,Global_Active_power,ylab="Global Active Power",xlab="",type="l")
plot(datetime,Voltage,ylab="Voltage",type="l")
plot(b$datetime,b$Sub_metering_1, type="l",xlab="",ylab="Energy Sub Metering", col="black")
lines(b$datetime,b$Sub_metering_2, type="l",xlab="",ylab="Energy Sub Metering", col="red")
lines(b$datetime,b$Sub_metering_3, type="l",xlab="",ylab="Energy Sub Metering", col="blue")
legend('topright',legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty='solid')
plot(datetime,Global_Reactive_power,ylab="Global Reactive power",type="l")

})
dev.off()
