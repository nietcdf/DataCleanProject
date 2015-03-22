# Code Book

## Short description of the original data

Data comes from:
==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

It represents data collected with help of 30 volunteers (age 19-48), while 
wearing a smartphone (Samsung Galaxy S II) on the waist. This allowed for collection of
3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.
Each of volunteers  performed six activities:
* WALKING
* WALKING_UPSTAIRS
* WALKING_DOWNSTAIRS 
* SITTING
* STANDING
* LAYING
Each experiment included video-recored material for manual labeling of data.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1]

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

## Short description of the tidy data set

The tidy data set can be generated using 'run_Analysis.R'. It contains a subset of the original data set, that includes
only mean and standard deviation values. We have made some changes to the original names, by removing '()', and replacing ','. 
Time and frequency domains were separated by '.' as well. The same was done to angle measurements.
Original data was split between 'test' and 'train' subsets. They were joined before extracting data used to create this tidy data set.
Values are unit-less, since they were normalized.


It contains 4 variables:
* subject
* activity.name
* mean
* parameter.name 
and has 15,480 observations, that represent mean calculated for each subject and activity, of each variable.

### General information about measurements
* t 
time domain
* f
 frequency domain, after applying a Fast Fourier Transform to time signals
* angle
 angle between vectors
* mean
 mean value
* std
 standard deviation
* X,Y,Z
 signals in directions of X, Y or Z
* BodyAcc
 body acceleration signal
* GravityAcc
 gravity acceleration signal
* BodyAccJerk
 linear acceleration
* BodyGyro
 angular velocity
* BodyGyroJerk
 angular velocity acceleration 
* BodyAccMag
 magnitude of body linear acceleration signal
* GravityAccMag
 magnitude of gravity acceleration signal
* BodyAccJerkMag
 magnitude of  linear acceleration jerk signal
* BodyGyroMag
 magnitude of angular velocity signal

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the 'angle' variable:

* gravityMean
* BodyAccMean
* BodyAccJerkMean
* BodyGyroMean
* BodyGyroJerkMean
* BodyGyroJerkMag
* BodyAcc
* BodyAccJerk
* BodyGyro
* BodyAccMag
* BodyAccJerkMag
* BodyGyroMag
* BodyGyroJerkMag
* BodyGyro



### List of  variables for which mean was calculated

* t.BodyAcc.mean.X
* t.BodyAcc.mean.Y
* t.BodyAcc.mean.Z
* t.BodyAcc.std.X
* t.BodyAcc.std.Y
* t.BodyAcc.std.Z
* t.GravityAcc.mean.X
* t.GravityAcc.mean.Y
* t.GravityAcc.mean.Z
* t.GravityAcc.std.X
* t.GravityAcc.std.Y
* t.GravityAcc.std.Z
* t.BodyAccJerk.mean.X
* t.BodyAccJerk.mean.Y
* t.BodyAccJerk.mean.Z
* t.BodyAccJerk.std.X
* t.BodyAccJerk.std.Y
* t.BodyAccJerk.std.Z
* t.BodyGyro.mean.X
* t.BodyGyro.mean.Y
* t.BodyGyro.mean.Z
* t.BodyGyro.std.X
* t.BodyGyro.std.Y
* t.BodyGyro.std.Z
* t.BodyGyroJerk.mean.X
* t.BodyGyroJerk.mean.Y
* t.BodyGyroJerk.mean.Z
* t.BodyGyroJerk.std.X
* t.BodyGyroJerk.std.Y
* t.BodyGyroJerk.std.Z
* t.BodyAccMag.mean
* t.BodyAccMag.std
* t.GravityAccMag.mean
* t.GravityAccMag.std
* t.BodyAccJerkMag.mean
* t.BodyAccJerkMag.std
* t.BodyGyroMag.mean
* t.BodyGyroMag.std
* t.BodyGyroJerkMag.mean
* t.BodyGyroJerkMag.std
* f.BodyAcc.mean.X
* f.BodyAcc.mean.Y
* f.BodyAcc.mean.Z
* f.BodyAcc.std.X
* f.BodyAcc.std.Y
* f.BodyAcc.std.Z
* f.BodyAcc.meanFreq.X
* f.BodyAcc.meanFreq.Y
* f.BodyAcc.meanFreq.Z
* f.BodyAccJerk.mean.X
* f.BodyAccJerk.mean.Y
* f.BodyAccJerk.mean.Z
* f.BodyAccJerk.std.X
* f.BodyAccJerk.std.Y
* f.BodyAccJerk.std.Z
* f.BodyAccJerk.meanFreq.X
* f.BodyAccJerk.meanFreq.Y
* f.BodyAccJerk.meanFreq.Z
* f.BodyGyro.mean.X
* f.BodyGyro.mean.Y
* f.BodyGyro.mean.Z
* f.BodyGyro.std.X
* f.BodyGyro.std.Y
* f.BodyGyro.std.Z
* f.BodyGyro.meanFreq.X
* f.BodyGyro.meanFreq.Y
* f.BodyGyro.meanFreq.Z
* f.BodyAccMag.mean
* f.BodyAccMag.std
* f.BodyAccMag.meanFreq
* f.BodyBodyAccJerkMag.mean
* f.BodyBodyAccJerkMag.std
* f.BodyBodyAccJerkMag.meanFreq
* f.BodyBodyGyroMag.mean
* f.BodyBodyGyroMag.std
* f.BodyBodyGyroMag.meanFreq
* f.BodyBodyGyroJerkMag.mean
* f.BodyBodyGyroJerkMag.std
* f.BodyBodyGyroJerkMag.meanFreq
* angle.tBodyAccmean.gravity
* angle.tBodyAccJerkmean.gravitymean
* angle.tBodyGyromean.gravitymean
* angle.tBodyGyroJerkmean.gravitymean
* angle.X.gravitymean
* angle.Y.gravitymean
* angle.Z.gravitymean
### Aditional variables
* activity.name
* subject
