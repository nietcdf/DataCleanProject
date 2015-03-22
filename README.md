# DataCleanProject
This repo includes files: run_analysis.R, CodeBook.md and README.md, as required
in a project for "Getting and Cleaning Data".




## Sofware used for data cleaning and calculations

* Operating System: OS X Yosemite Version 10.10.2
* R environment: 
RStudio
Version 0.98.1091 – © 2009-2014 RStudio, Inc.
Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/600.3.18 (KHTML, like Gecko)

## Packages used

* plyr
* dplyr

## Data used

Data is described at:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Original data came from: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## Main steps of the project
R script is called run_analysis.R and does the following: 
 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive variable names. 
 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### R code highlights
#### Step 1: Read and merge data
#################### train data ######################
dataFile1 <- "UCI\ HAR\ Dataset/train/X_train.txt"
if (!file.exists(dataFile1) ){
        print("problem opening a data file train")
}
data1 <- read.table(dataFile1)


activityFile1 <- "UCI\ HAR\ Dataset/train/y_train.txt"
if (!file.exists(activityFile1) ){
        print("problem opening a data file train")
}
activity1 <- read.table(activityFile1)


subjectFile1 <- "UCI\ HAR\ Dataset/train/subject_train.txt"
if (!file.exists(subjectFile1) ){
        print("problem opening a data file train")
}
subject1 <- read.table(subjectFile1)
#################### test data ######################
dataFile2 <- "UCI\ HAR\ Dataset/test/X_test.txt"
if (!file.exists(dataFile2) ){
        print("problem opening a data file test")
}
data2 <- read.table(dataFile2)


activityFile2 <- "UCI\ HAR\ Dataset/test/y_test.txt"
if (!file.exists(activityFile2) ){
        print("problem opening a data file test")
}
activity2 <- read.table(activityFile2)


subjectFile2 <- "UCI\ HAR\ Dataset/test/subject_test.txt"
if (!file.exists(subjectFile2) ){
        print("problem opening a data file test")
}
subject2 <- read.table(subjectFile2)
#################### field labels ##############
labelFileName <- "UCI\ HAR\ Dataset/features.txt"
if (!file.exists(labelFileName) ){
        print("problem opening a label file")
}
label2 <- read.table(labelFileName)

#################### activity labels ##############
activityFileName <- "UCI\ HAR\ Dataset/activity_labels.txt"
if (!file.exists(activityFileName) ){
        print("problem opening a label file")
}
activityLabels <- read.table(activityFileName, stringsAsFactors=FALSE, header=FALSE)

##### merge code
mergedDataSet<-rbind(data1,data2)

#### Step 2:  Extract only the measurements on the mean and standard deviation for each measurement.
meanStdColumns<-grepl("mean", label2$V2) | grepl("std",label2$V2)

#### Step 3: Uses descriptive activity names to name the activities in the data set
##############attach labels to columns of data1 #
names(data1)<-label2$V2
names(data2)<-label2$V2

data1$"activity.name" <- activity1$"activity.name"
data2$"activity.name" <- activity2$"activity.name"

mergedDataSet<-rbind(data1,data2)

############## combined subjcet files
subject <- rbind(subject1,subject2)
names(subject)<-c("subject")
mergedDataSet$subject <- subject$subject

#### Step 4:  Uses descriptive activity names to name the activities in the data set
##############unify naming: replace , with -
label2$V2<-gsub(",",".",label2$V2)
##############remove () from names
label2$V2<-gsub("[(]","",label2$V2)
label2$V2<-gsub("[)]","",label2$V2)
##############separate angle from the rest of variable body
label2$V2<-gsub("angle","angle.",label2$V2)
##############separate t from the rest of the variable body
label2$V2<-gsub("^t","t.",label2$V2)
##############separate f from the rest of the variable body
label2$V2<-gsub("^f","f.",label2$V2)
##############change Mean to mean, to make it more uniform
label2$V2<-gsub("Mean","mean",label2$V2)
##############change - to . , to make it easier to work with
label2$V2<-gsub("-",".",label2$V2)

#### Step 5: Creates a tidy data set while calculationg mean for columns

############## a list of calls to 
############## t.BodyAcc.mean.Y

cdata <- ddply(dt, selFld, summarise, mean = mean(t.BodyAcc.mean.Y))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.BodyAcc.mean.Y",numOfElem) 
results <- rbind(results,cdata) 


############## t.BodyAcc.mean.Z 

cdata <- ddply(dt, selFld, summarise, mean = mean(t.BodyAcc.mean.Z))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.BodyAcc.mean.Z",numOfElem) 
results <- rbind(results,cdata)

and so on ..
#### Finally output results:

write.table(results,"tidy.txt", row.name=FALSE )
