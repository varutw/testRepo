
#set working directory
setwd("C:/Users/Acer/testRepo/projectCourse4Week1")

#read data from text file
data<-read.csv("household_power_consumption.txt",sep=";")

#set local time of computer into English
Sys.setlocale("LC_TIME", "C")

library(lubridate)

#merge Date and Time data into one column called DateAndTime
data$DateAndTime<-as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
data$Date<-as.Date(x=data$Date,format="%d/%m/%Y")

#subset data only 2 days to be used in the plot 
dataUse<-subset(data,Date=="2007-02-01"|Date=="2007-02-02")

#format values from factor class into character first and then
#into numeric
dataUse$Sub_metering_1<-as.numeric(as.character(dataUse$Sub_metering_1))
dataUse$Sub_metering_2<-as.numeric(as.character(dataUse$Sub_metering_2))
dataUse$Sub_metering_3<-as.numeric(as.character(dataUse$Sub_metering_3))

#save the following plots as png
png(filename = "plot3.png",width = 480,height = 480)

with(dataUse,plot(DateAndTime,Sub_metering_1,col="black",
                  type = "l",ylab="Energy sub metering",
                  xlab=""))
with(dataUse,lines(DateAndTime,Sub_metering_2,col="red"))
with(dataUse,lines(DateAndTime,Sub_metering_3,col="blue"))
#add legend
legend("topright",lty=1,col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


dev.off()     