
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


#format global active power from factor class into character first and then
#into numeric
dataUse$Global_active_power<-as.numeric(as.character(dataUse$Global_active_power))

#save the following plots as png
png(filename = "plot2.png",width = 480,height = 480)

#create line plot
with(dataUse,plot(DateAndTime,Global_active_power,
                  type = "l",ylab="Global Active Power (kilowatts)",
                  xlab=""))

dev.off()
