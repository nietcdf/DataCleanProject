#1. Merge the training and the test sets to create one data set.
#
#                  read data files 
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


############## label replacement #########################
# 4: create meaningful names

#unify naming: replace , with -
label2$V2<-gsub(",",".",label2$V2)
#remove () from names
label2$V2<-gsub("[(]","",label2$V2)
label2$V2<-gsub("[)]","",label2$V2)
#separate angle from the rest of variable body
label2$V2<-gsub("angle","angle.",label2$V2)
#separate t from the rest of the variable body
label2$V2<-gsub("^t","t.",label2$V2)
#separate f from the rest of the variable body
label2$V2<-gsub("^f","f.",label2$V2)
#change Mean to mean, to make it more uniform
label2$V2<-gsub("Mean","mean",label2$V2)
#change - to . , to make it easier to work with
label2$V2<-gsub("-",".",label2$V2)

#### prepare activity data for a column of activity names corresponding
# to their numbers

activity2$V2<-activity2$V1
activity1$V2<-activity1$V1
names(activityLabels) <- c("act.number", "activity.name")
names(activity1) <- c("act.number", "activity.name")
names(activity2) <- c("act.number", "activity.name")



for(counter in 1:6) {
        activity1$"activity.name"[activity1$"act.number" == activityLabels$"act.number"[counter]]<-activityLabels$"activity.name"[counter]
        activity2$"activity.name"[activity2$"act.number" == activityLabels$"act.number"[counter]]<-activityLabels$"activity.name"[counter]        
}


################## combine both data sets together #########
# attach labels to columns of data1 #
names(data1)<-label2$V2
names(data2)<-label2$V2

data1$"activity.name" <- activity1$"activity.name"
data2$"activity.name" <- activity2$"activity.name"

mergedDataSet<-rbind(data1,data2)

# combined subjcet files
subject <- rbind(subject1,subject2)
names(subject)<-c("subject")
mergedDataSet$subject <- subject$subject

#######              prepare the sub-selection with mean and std
# 2: Extract only the measurements on the mean and standard deviation for each measurement.
meanStdColumns<-grepl("mean", label2$V2) | grepl("std",label2$V2)

library(dplyr)
dt<-tbl_df(mergedDataSet[,meanStdColumns])
# 3: 3: Uses descriptive activity names to name the activities in the data set
# field names were replaced, and unified before these fields were extracted 

# 5: From the data set in step 4, creates a second, 
#       independent tidy data set with the average 
#       of each variable for each activity and each subject.
library(plyr)
fields <- names(dt)
fields <- fields[fields!="subject"]
fields <- fields[fields!="activity.name"]



selFld <- c("subject", "activity.name")

#### t.BodyAcc.mean.X ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.BodyAcc.mean.X))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.BodyAcc.mean.X",numOfElem) 
results <- cdata


#### t.BodyAcc.mean.Y ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.BodyAcc.mean.Y))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.BodyAcc.mean.Y",numOfElem) 
results <- rbind(results,cdata) 


#### t.BodyAcc.mean.Z ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.BodyAcc.mean.Z))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.BodyAcc.mean.Z",numOfElem) 
results <- rbind(results,cdata) 


#### t.BodyAcc.std.X ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.BodyAcc.std.X))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.BodyAcc.std.X",numOfElem) 
results <- rbind(results,cdata) 


#### t.BodyAcc.std.Y ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.BodyAcc.std.Y))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.BodyAcc.std.Y",numOfElem) 
results <- rbind(results,cdata) 


#### t.BodyAcc.std.Z ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.BodyAcc.std.Z))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.BodyAcc.std.Z",numOfElem) 
results <- rbind(results,cdata) 


#### t.GravityAcc.mean.X ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.GravityAcc.mean.X))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.GravityAcc.mean.X",numOfElem) 
results <- rbind(results,cdata) 


#### t.GravityAcc.mean.Y ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.GravityAcc.mean.Y))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.GravityAcc.mean.Y",numOfElem) 
results <- rbind(results,cdata) 


#### t.GravityAcc.mean.Z ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.GravityAcc.mean.Z))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.GravityAcc.mean.Z",numOfElem) 
results <- rbind(results,cdata) 


#### t.GravityAcc.std.X ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.GravityAcc.std.X))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.GravityAcc.std.X",numOfElem) 
results <- rbind(results,cdata) 


#### t.GravityAcc.std.Y ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.GravityAcc.std.Y))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.GravityAcc.std.Y",numOfElem) 
results <- rbind(results,cdata) 


#### t.GravityAcc.std.Z ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.GravityAcc.std.Z))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.GravityAcc.std.Z",numOfElem) 
results <- rbind(results,cdata) 


#### t.BodyAccJerk.mean.X ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.BodyAccJerk.mean.X))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.BodyAccJerk.mean.X",numOfElem) 
results <- rbind(results,cdata) 


#### t.BodyAccJerk.mean.Y ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.BodyAccJerk.mean.Y))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.BodyAccJerk.mean.Y",numOfElem) 
results <- rbind(results,cdata) 


#### t.BodyAccJerk.mean.Z ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.BodyAccJerk.mean.Z))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.BodyAccJerk.mean.Z",numOfElem) 
results <- rbind(results,cdata) 


#### t.BodyAccJerk.std.X ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.BodyAccJerk.std.X))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.BodyAccJerk.std.X",numOfElem) 
results <- rbind(results,cdata) 


#### t.BodyAccJerk.std.Y ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.BodyAccJerk.std.Y))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.BodyAccJerk.std.Y",numOfElem) 
results <- rbind(results,cdata) 


#### t.BodyAccJerk.std.Z ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.BodyAccJerk.std.Z))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.BodyAccJerk.std.Z",numOfElem) 
results <- rbind(results,cdata) 


#### t.BodyGyro.mean.X ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.BodyGyro.mean.X))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.BodyGyro.mean.X",numOfElem) 
results <- rbind(results,cdata) 


#### t.BodyGyro.mean.Y ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.BodyGyro.mean.Y))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.BodyGyro.mean.Y",numOfElem) 
results <- rbind(results,cdata) 


#### t.BodyGyro.mean.Z ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.BodyGyro.mean.Z))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.BodyGyro.mean.Z",numOfElem) 
results <- rbind(results,cdata) 


#### t.BodyGyro.std.X ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.BodyGyro.std.X))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.BodyGyro.std.X",numOfElem) 
results <- rbind(results,cdata) 


#### t.BodyGyro.std.Y ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.BodyGyro.std.Y))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.BodyGyro.std.Y",numOfElem) 
results <- rbind(results,cdata) 


#### t.BodyGyro.std.Z ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.BodyGyro.std.Z))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.BodyGyro.std.Z",numOfElem) 
results <- rbind(results,cdata) 


#### t.BodyGyroJerk.mean.X ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.BodyGyroJerk.mean.X))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.BodyGyroJerk.mean.X",numOfElem) 
results <- rbind(results,cdata) 


#### t.BodyGyroJerk.mean.Y ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.BodyGyroJerk.mean.Y))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.BodyGyroJerk.mean.Y",numOfElem) 
results <- rbind(results,cdata) 


#### t.BodyGyroJerk.mean.Z ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.BodyGyroJerk.mean.Z))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.BodyGyroJerk.mean.Z",numOfElem) 
results <- rbind(results,cdata) 


#### t.BodyGyroJerk.std.X ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.BodyGyroJerk.std.X))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.BodyGyroJerk.std.X",numOfElem) 
results <- rbind(results,cdata) 


#### t.BodyGyroJerk.std.Y ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.BodyGyroJerk.std.Y))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.BodyGyroJerk.std.Y",numOfElem) 
results <- rbind(results,cdata) 


#### t.BodyGyroJerk.std.Z ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.BodyGyroJerk.std.Z))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.BodyGyroJerk.std.Z",numOfElem) 
results <- rbind(results,cdata) 


#### t.BodyAccMag.mean ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.BodyAccMag.mean))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.BodyAccMag.mean",numOfElem) 
results <- rbind(results,cdata) 


#### t.BodyAccMag.std ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.BodyAccMag.std))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.BodyAccMag.std",numOfElem) 
results <- rbind(results,cdata) 


#### t.GravityAccMag.mean ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.GravityAccMag.mean))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.GravityAccMag.mean",numOfElem) 
results <- rbind(results,cdata) 


#### t.GravityAccMag.std ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.GravityAccMag.std))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.GravityAccMag.std",numOfElem) 
results <- rbind(results,cdata) 


#### t.BodyAccJerkMag.mean ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.BodyAccJerkMag.mean))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.BodyAccJerkMag.mean",numOfElem) 
results <- rbind(results,cdata) 


#### t.BodyAccJerkMag.std ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.BodyAccJerkMag.std))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.BodyAccJerkMag.std",numOfElem) 
results <- rbind(results,cdata) 


#### t.BodyGyroMag.mean ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.BodyGyroMag.mean))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.BodyGyroMag.mean",numOfElem) 
results <- rbind(results,cdata) 


#### t.BodyGyroMag.std ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.BodyGyroMag.std))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.BodyGyroMag.std",numOfElem) 
results <- rbind(results,cdata) 


#### t.BodyGyroJerkMag.mean ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.BodyGyroJerkMag.mean))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.BodyGyroJerkMag.mean",numOfElem) 
results <- rbind(results,cdata) 


#### t.BodyGyroJerkMag.std ####

cdata <- ddply(dt, selFld, summarise, mean = mean(t.BodyGyroJerkMag.std))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("t.BodyGyroJerkMag.std",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyAcc.mean.X ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyAcc.mean.X))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyAcc.mean.X",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyAcc.mean.Y ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyAcc.mean.Y))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyAcc.mean.Y",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyAcc.mean.Z ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyAcc.mean.Z))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyAcc.mean.Z",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyAcc.std.X ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyAcc.std.X))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyAcc.std.X",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyAcc.std.Y ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyAcc.std.Y))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyAcc.std.Y",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyAcc.std.Z ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyAcc.std.Z))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyAcc.std.Z",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyAcc.meanFreq.X ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyAcc.meanFreq.X))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyAcc.meanFreq.X",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyAcc.meanFreq.Y ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyAcc.meanFreq.Y))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyAcc.meanFreq.Y",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyAcc.meanFreq.Z ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyAcc.meanFreq.Z))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyAcc.meanFreq.Z",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyAccJerk.mean.X ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyAccJerk.mean.X))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyAccJerk.mean.X",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyAccJerk.mean.Y ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyAccJerk.mean.Y))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyAccJerk.mean.Y",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyAccJerk.mean.Z ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyAccJerk.mean.Z))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyAccJerk.mean.Z",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyAccJerk.std.X ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyAccJerk.std.X))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyAccJerk.std.X",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyAccJerk.std.Y ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyAccJerk.std.Y))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyAccJerk.std.Y",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyAccJerk.std.Z ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyAccJerk.std.Z))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyAccJerk.std.Z",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyAccJerk.meanFreq.X ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyAccJerk.meanFreq.X))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyAccJerk.meanFreq.X",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyAccJerk.meanFreq.Y ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyAccJerk.meanFreq.Y))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyAccJerk.meanFreq.Y",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyAccJerk.meanFreq.Z ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyAccJerk.meanFreq.Z))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyAccJerk.meanFreq.Z",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyGyro.mean.X ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyGyro.mean.X))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyGyro.mean.X",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyGyro.mean.Y ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyGyro.mean.Y))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyGyro.mean.Y",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyGyro.mean.Z ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyGyro.mean.Z))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyGyro.mean.Z",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyGyro.std.X ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyGyro.std.X))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyGyro.std.X",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyGyro.std.Y ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyGyro.std.Y))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyGyro.std.Y",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyGyro.std.Z ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyGyro.std.Z))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyGyro.std.Z",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyGyro.meanFreq.X ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyGyro.meanFreq.X))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyGyro.meanFreq.X",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyGyro.meanFreq.Y ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyGyro.meanFreq.Y))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyGyro.meanFreq.Y",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyGyro.meanFreq.Z ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyGyro.meanFreq.Z))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyGyro.meanFreq.Z",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyAccMag.mean ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyAccMag.mean))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyAccMag.mean",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyAccMag.std ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyAccMag.std))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyAccMag.std",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyAccMag.meanFreq ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyAccMag.meanFreq))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyAccMag.meanFreq",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyBodyAccJerkMag.mean ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyBodyAccJerkMag.mean))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyBodyAccJerkMag.mean",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyBodyAccJerkMag.std ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyBodyAccJerkMag.std))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyBodyAccJerkMag.std",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyBodyAccJerkMag.meanFreq ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyBodyAccJerkMag.meanFreq))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyBodyAccJerkMag.meanFreq",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyBodyGyroMag.mean ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyBodyGyroMag.mean))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyBodyGyroMag.mean",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyBodyGyroMag.std ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyBodyGyroMag.std))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyBodyGyroMag.std",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyBodyGyroMag.meanFreq ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyBodyGyroMag.meanFreq))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyBodyGyroMag.meanFreq",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyBodyGyroJerkMag.mean ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyBodyGyroJerkMag.mean))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyBodyGyroJerkMag.mean",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyBodyGyroJerkMag.std ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyBodyGyroJerkMag.std))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyBodyGyroJerkMag.std",numOfElem) 
results <- rbind(results,cdata) 


#### f.BodyBodyGyroJerkMag.meanFreq ####

cdata <- ddply(dt, selFld, summarise, mean = mean(f.BodyBodyGyroJerkMag.meanFreq))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("f.BodyBodyGyroJerkMag.meanFreq",numOfElem) 
results <- rbind(results,cdata) 


#### angle.tBodyAccmean.gravity ####

cdata <- ddply(dt, selFld, summarise, mean = mean(angle.tBodyAccmean.gravity))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("angle.tBodyAccmean.gravity",numOfElem) 
results <- rbind(results,cdata) 


#### angle.tBodyAccJerkmean.gravitymean ####

cdata <- ddply(dt, selFld, summarise, mean = mean(angle.tBodyAccJerkmean.gravitymean))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("angle.tBodyAccJerkmean.gravitymean",numOfElem) 
results <- rbind(results,cdata) 


#### angle.tBodyGyromean.gravitymean ####

cdata <- ddply(dt, selFld, summarise, mean = mean(angle.tBodyGyromean.gravitymean))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("angle.tBodyGyromean.gravitymean",numOfElem) 
results <- rbind(results,cdata) 


#### angle.tBodyGyroJerkmean.gravitymean ####

cdata <- ddply(dt, selFld, summarise, mean = mean(angle.tBodyGyroJerkmean.gravitymean))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("angle.tBodyGyroJerkmean.gravitymean",numOfElem) 
results <- rbind(results,cdata) 


#### angle.X.gravitymean ####

cdata <- ddply(dt, selFld, summarise, mean = mean(angle.X.gravitymean))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("angle.X.gravitymean",numOfElem) 
results <- rbind(results,cdata) 


#### angle.Y.gravitymean ####

cdata <- ddply(dt, selFld, summarise, mean = mean(angle.Y.gravitymean))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("angle.Y.gravitymean",numOfElem) 
results <- rbind(results,cdata) 


#### angle.Z.gravitymean ####

cdata <- ddply(dt, selFld, summarise, mean = mean(angle.Z.gravitymean))
numOfElem <- length(cdata[[1]]) 
cdata$parameter.name <- rep("angle.Z.gravitymean",numOfElem) 
results <- rbind(results,cdata) 

###### output results ########
write.table(results,"tidy.txt", row.name=FALSE )