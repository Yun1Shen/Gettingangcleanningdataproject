#the function read and merge data from test and train
readfile<-function(test,train){
  files_test=list.files(pattern="*.txt$",path=test)
  files_train=list.files(pattern="*.txt$",path=train)
  mydata<-list()
  for(i in 1:length(files_test)){
    file_test<-read.table(paste0(test,files_test[i]))
    file_train<-read.table(paste0(train,files_train[i]))
    mydata[[i]]<-rbind(file_test,file_train)
    
  }
  names(mydata)<-gsub("_test.txt","",files_test)
  names(mydata)<-stringr::str_replace(files_test, pattern = "_test.txt", replacement = "")
  mydata
}

#read test data into table
train<-list()
test<-list()
testsig<-list()
trainsig<-list()
homedirectory="UCI HAR Dataset/"
testpath="UCI HAR Dataset/test/"
trainpath="UCI HAR Dataset/train/"
testsigpath="UCI HAR Dataset/test/Inertial Signals/"
trainsigpath="UCI HAR Dataset/test/Inertial Signals/"

#get the merged data
datamerge<-readfile(testpath,trainpath)

activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt")
features<-read.table("UCI HAR Dataset/features.txt")
#extract the index of the feature we need
featuresneed<-grep(".*mean>*|.*std.*",features[,2])
#The merged datax with only the needed features
dataX<-datamerge[[2]][,featuresneed]
#Uses descriptive activity names to name the activities in the data set
dataX$activities<-factor(datamerge[[3]]$V1,levels=activity_labels[,1],labels=activity_labels[,2])
# labels the data set with descriptive variable names.
colnames(dataX)[1:79]=grep(".*mean>*|.*std.*",features[,2],value=TRUE)
# merge the subject with the dataX
dataX$subject<-datamerge[[1]][,1]
#The first dataset
firstdata<-dataX %>% select(subject,activities,everything())%>%arrange(subject)
#The second with the average of each variable for each activity and each subject.
seconddata<-dataX%>%group_by(subject,activities)%>%summarise_all("mean")
write.table(seconddata,file="tidydata.txt",row.names = FALSE,quote = FALSE)
