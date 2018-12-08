#read all training data and combine them
setwd("D:/Google Drive/dataScientist/UCI HAR Dataset/train")
subjectTrain<-read.csv("subject_train.txt",head=FALSE)
xTrain<-read.csv("X_train.txt",sep="",head=FALSE)
yTrain<-read.csv("y_train.txt",head=FALSE)

data<-data.frame()
data<-cbind(subjectTrain,yTrain,xTrain)

#read all testing data and combine them
setwd("D:/Google Drive/dataScientist/UCI HAR Dataset/test")
subjectTest<-read.csv("subject_test.txt",head=FALSE)
xTest<-read.csv("X_test.txt",sep="",head=FALSE)
yTest<-read.csv("y_test.txt",head=FALSE)

data2<-data.frame()
data2<-cbind(subjectTest,yTest,xTest)

#combine testing and training data into dataNew
dataNew<-rbind(data,data2)

#extract name of column from features file
setwd("D:/Google Drive/dataScientist/UCI HAR Dataset")
features<-scan("features.txt",what=character())
featuresNew<-features[seq(2,length(features),2)]

#rename the columns of dataNew file and order by subject and label
colnames(dataNew)<-c("subject","label",featuresNew)
dataNew<-dataNew[order(dataNew$subject,dataNew$label),]

#extract only mean and std features Exclude the angle between 
#Mean and other components, and exclude meanFreq
extractMeanStd<-featuresNew[(grepl("mean",featuresNew) |
                         grepl("std",featuresNew))& 
                         !grepl("Freq",featuresNew)]
dataNew<-dataNew[,c("subject","label",extractMeanStd)]

#find average value of each features for each subject and label
bin<-list()
for (i in 1:30){
  for (j in 1:6){
    if(i==1&j==1){k<-1}
    cal<-dataNew[(dataNew$subject==i&dataNew$label==j),]
    avg<-data.frame(lapply(cal[,extractMeanStd],mean))
    avg$subject<-i
    avg$label<-j
    bin[[k]]<-avg
    k<-k+1
  }
}

#combine average data into tidy data set
dataComplete <-bind_rows(bin)
colnames(dataComplete)<-c(extractMeanStd,"subject","label")
dataComplete<-subset(dataComplete,select=c("subject","label",extractMeanStd))

#write into text file
write.table(dataComplete,"tidyDataSet.txt",row.name=FALSE)
