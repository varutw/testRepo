
#set working directory
setwd("C:/Users/Acer/testRepo/projectCourse4Week1")

#read data from text file
data<-read.csv("household_power_consumption.txt",sep=";")

#set local time of computer into English
Sys.setlocale("LC_TIME", "C")

library(lubridate)

#merge Date and Time data into one column called datetime
data$datetime<-as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
data$Date<-as.Date(x=data$Date,format="%d/%m/%Y")

#subset data only 2 days to be used in the plot 
dataUse<-subset(data,Date=="2007-02-01"|Date=="2007-02-02")


#format values from factor class into character first and then
#into numeric
dataUse$Sub_metering_1<-as.numeric(as.character(dataUse$Sub_metering_1))
dataUse$Sub_metering_2<-as.numeric(as.character(dataUse$Sub_metering_2))
dataUse$Sub_metering_3<-as.numeric(as.character(dataUse$Sub_metering_3))
dataUse$Voltage<-as.numeric(as.character(dataUse$Voltage))
dataUse$Global_active_power<-as.numeric(as.character(dataUse$Global_active_power))
dataUse$Global_reactive_power<-as.numeric(as.character(dataUse$Global_reactive_power))

#save the following plots as png
png(filename = "plot4.png",width = 480,height = 480)

#create space for 4 plot, 2 by 2
par(mfrow=c(2,2),mar=c(4,4,4,4))

#create 4 required plots 
with(dataUse,plot(datetime,Global_active_power,
                  type = "l",ylab="Global Active Power",
                  xlab=""))

with(dataUse,plot(datetime,Voltage,type = "l"))

with(dataUse,plot(datetime,Sub_metering_1,col="black",
                  type = "l",ylab="Energy sub metering",
                  xlab=""))
with(dataUse,lines(datetime,Sub_metering_2,col="red"))
with(dataUse,lines(datetime,Sub_metering_3,col="blue"))
legend("topright",lty=1,lwd=1,col=c("black","red","blue"),cex=0.8,
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


with(dataUse,plot(datetime,Global_reactive_power,type = "l"))

dev.off()
