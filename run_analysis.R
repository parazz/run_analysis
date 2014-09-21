#Step 1, Merges the training and the test sets to create one data set.

## Read all the data files in the directory and combine them into one dataset.
subject_test<-read.table('./UCI HAR Dataset/test/subject_test.txt',header=F)
Xtest<-read.table('./UCI HAR Dataset/test/X_test.txt',header=F)
ytest<-read.table('./UCI HAR Dataset/test/y_test.txt',header=F)
testdf<-cbind(subject_test,Xtest,ytest)

subject_train<-read.table('./UCI HAR Dataset/train/subject_train.txt',header=F)
Xtrain<-read.table('./UCI HAR Dataset/train/X_train.txt',header=F)
ytrain<-read.table('./UCI HAR Dataset/train/y_train.txt',header=F)
traindf<-cbind(subject_train,Xtrain,ytrain)
## The training and the test sets have been put into one set.
ttdf <-rbind(testdf,traindf)

#Step 2, Extracts only the measurements on the mean and standard deviation for each measurement. 

## Use certain functions to filter and collect the columns we need, which are the variables related to mean and standard deviation.
library(dplyr)
temp<-read.table('./UCI HAR Dataset/features.txt')
temp2<-data.frame()%>%
paste(temp$V2)
names(ttdf)[2:562] <- temp2
names(ttdf)[1] <- 'subject'
names(ttdf)[563] <- 'label'

extract_mean <- select(ttdf,matches('-mean()'),-matches('-meanFreq()'))
extract_std <- select(ttdf,matches('-std()'))
extract <- cbind(extract_mean,extract_std)
extract <- cbind(ttdf$label,extract)
names(extract)[1] <- 'label'

 
#Step 3, Uses descriptive activity names to name the activities in the data set

## Replace all the label number with the according activity name.
extract$label <-as.character(extract$label)
extract$label[extract$label =='1'] <-'WALKING'
extract$label[extract$label =='2'] <-'WALKING_UPSTAIRS'
extract$label[extract$label =='3'] <-'WALKING_DOWNSTAIRS'
extract$label[extract$label =='4'] <-'SITTING'
extract$label[extract$label =='5'] <-'STANDING'
extract$label[extract$label =='6'] <-'LAYING'

#Step 4, Appropriately labels the data set with descriptive variable names. 

## Remove all "()"s from the column name, however, the rest stays the same.
names(extract) <- gsub("std()","std",names(extract),fixed=T) 
names(extract) <- gsub("mean()","mean",names(extract),fixed=T) 

#Step 5, From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Order the tidy data set with respect the subject number. Then, calculate the results we need using the functions.
extract <- cbind(ttdf$subject,extract)
names(extract)[1] <- 'subject'
tidy_dat <- arrange(extract,subject)

library(dplyr);library(plyr)
result <- ddply(tidy_dat, .(subject,label), numcolwise(mean))

write.table(result,file='run_analysis.txt',row.names=F)
