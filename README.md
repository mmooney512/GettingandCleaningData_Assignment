---
title: "Getting and Cleaning Data - Week 4 Assignment"
---

## Getting and Cleaning Data - Week 4 Assignment

### File Descriptions
* README.md: short description of repo and contained files
* CodeBook.md: describing variables in the data sets
* run_analysis.R: script used to modify and summarize the data sets

### Source Data
Website: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### Summary of the Caputured Data:

### Attribute Information:
For each record in the dataset it is provided: 
* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.

###Feature Selection
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

### Feature Selection:
time Body Acceleration-XYZ
time Gravity Acceleration-XYZ
time Body AccelerationJerk-XYZ
time Body Gyro-XYZ
time Body GyroJerk-XYZ
time Body AccelerationMag
time Gravity AccelerationMag
time Body Acceleration Jerk Mag 
time Body GyroMag
time Body GyroJerkMag
f Body Acceleration-XYZ
f Body AccelerationJerk-XYZ
f Body Gyro-XYZ
f Body AccelerationMag
f Body Acceleration Jerk Mag 
f Body GyroMag
f Body GyroJerkMag

### Data Summerization:
The set of variables that were estimated from these signals are: 
* mean: Average Mean value
* Standard deviation: Average Standard deviation
