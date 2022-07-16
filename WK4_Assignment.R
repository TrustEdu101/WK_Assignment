library(dplyr)
setwd("D:/UCI HAR Dataset")
x_train <-read.table("./train/X_train.txt")
y_train <-read.table("./train/y_train.txt")
sub_train <-read.table("./train/subject_train.txt")
x_test <-read.table("./test/X_test.txt")
y_test <=read.table("./test/y_test.txt")
sub_test<-read.table("./test/subject_test.txt")
features<-read.table("./features.txt")
actvity_labels<-read.table("./actvity_labels.txt")
x_total <-rbind(x_train,x_test)
y_total <-rbind(y_train,y_test)
sub_total<-rbind(sub_train,sub_test)
colnames(x_train)<-features[,2]
colnames(y_train)<-"activityID"
colnames(sub_train)<-"subjectID"
colnames(x_test)<-features[,2]
colnames(y_test)<-"activityID"
colnames(sub_test)<-"subjectID"
colnames(activity_labels)<-c('activityID','activityType')
mrg_train=cbind(y_train,sub_train,x_train)
mrg_test=cbind(y_test,sub_test,x_test)
setAllInOne=rbind(mrg_train,mrg_test)
colNames=colnames(setAllInOne)
mean_and_std=(grepl("activityID",colNames)| grepl("SubjectID",colNames)| grepl("mean..",colNames)| grepl("std..",colNames))
setForMeanAndStd<-setAllInOne[,mean_and_std==TRUE]
setWithactivityNames=merge(setForMeanAndStd, activity_labels, by='activityID', all.x=TRUE)
secTidySet<-aggregate(.~subjectID+activityID,setWithActivityNames, mean)
secTidySet<-secTidySet[order(secTidySet$subjectID,secTidySet$activityID),]
write.table(secTidySet,"secTidyset.txt", row.name=FALSE)
