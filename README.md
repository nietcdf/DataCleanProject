# DataCleanProject
This repo includes files: run_analysis.R, CodeBook.md and README.md, as required
in a project for "Getting and Cleaning Data".




## Sofware used for data cleaning and calculations

* Operating System: OS X Yosemite Version 10.10.2
* R environment
RStudio
Version 0.98.1091 – © 2009-2014 RStudio, Inc.
Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/600.3.18 (KHTML, like Gecko)

## Packages used

* plyr
* dplyr

## Data used


http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## Main steps of the project
R script is called run_analysis.R that does the following: 
 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive variable names. 
 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


