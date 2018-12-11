#set working directory
setwd("C:/Users/Acer/testRepo/projectCourse4Week1")

#read data from text file
data<-read.csv("household_power_consumption.txt",sep=";")

#format Date data from factor class
data$Date<-as.Date(x=data$Date,format="%d/%m/%Y")

#format global active power from factor class into character first and then
#into numeric
data$Global_active_power<-as.numeric(as.character(data$Global_active_power))

#subset data only 2 days to be used in the plot 
dataUse<-subset(data,Date=="2007-02-01"|Date=="2007-02-02")

#save the following plots as png
png(filename = "plot1.png",width = 480,height = 480)

#create histogram
hist(dataUse$Global_active_power,col="red",
     xlab="Global Active Power (kilowatts)",
     main="Global Active Power")

dev.off()