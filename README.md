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
#### Step 1
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
