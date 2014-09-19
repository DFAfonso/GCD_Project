##Getting and Cleaning Data - Course Project Code Book


###Description:

The data for this assignment was collected from the accelerometers from the Samsung Galaxy S smartphone.
Data for the project was provided at the following link:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

**Data Set Information:**

This information is from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

*"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data."* 

```
Feature Selection 
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'
```

**Data Files Imported into R**:
The following raw data files were read into R for processing:

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.


**Methods used to process the data**:

* The various Test (x_test, y_test,subject_test) and Train files (x_train, y_train, subject_train) were read into R via the *read.table()* function.  The features.txt and activity_labels.txt files were similarly read into R.
* They were merged into 1 data set - *complete_data* - a data.frame with 563 variables and 10299 observations.
* A *column_Names* variable was created from information read in from the features.txt file.   It was augmented with 2 additional rows containing "ActivityID" and "SubjectID" values.   These were added to ensure correct column names were given to all 563 columns in the *complete_data* data frame. 
* *complete_data* was subsetted (as requested) and a new data variable was created containing only the mean and standard deviation of the measurements.  The ignore.case argument was used in the grepl function, as there were some instances of both "mean" and "Mean" in the data.  "ActivityID" and "SubjectID" were also included to ensure they weren't dropped off from the search.
* This new data frame, *data_mean_SD*, consisted of 89 variables 10299 observations.
* The data read in from the activity_labels.txt file was then used to assign "activity" names to the ActivityID's in the *data_mean_SD* data frame.   These were merged using the *merge()* function.
* The activity names were the following:

```
  ActivityID       ActivityName
          1            WALKING
          2   WALKING_UPSTAIRS
          3 WALKING_DOWNSTAIRS
          4            SITTING
          5           STANDING
          6             LAYING
```
* The *gsub()* function was then applied to in order to provide more "user-friendly" and "descriptive" column names.  Changes made to the column names consisted of the following:

```
names(data_mean_SD) <- gsub('tBody', 'time_Body_',names(data_mean_SD))
names(data_mean_SD) <- gsub('tGravity', 'time_Gravity_', names(data_mean_SD))
names(data_mean_SD) <- gsub('fBody', 'frequency_Body_',names(data_mean_SD))
names(data_mean_SD) <- gsub('tGravity', 'frequency_Gravity_', names(data_mean_SD))
names(data_mean_SD) <- gsub('[-()]', '', names(data_mean_SD))
names(data_mean_SD) <- gsub('angle', 'angle_', names(data_mean_SD))
names(data_mean_SD) <- gsub('Mean', '_Mean', names(data_mean_SD))
names(data_mean_SD) <- gsub('Magmean', '_Magnitude_Mean_', names(data_mean_SD))
names(data_mean_SD) <- gsub('mean', '_Mean_', names(data_mean_SD))
names(data_mean_SD) <- gsub('std', '_Standard_Deviation_', names(data_mean_SD))
names(data_mean_SD) <- gsub('Jerk', '_Jerk', names(data_mean_SD))
names(data_mean_SD) <- gsub('Freq', 'Frequency_', names(data_mean_SD))
names(data_mean_SD) <- gsub('Acc', 'Acceleration', names(data_mean_SD))

```
* The next step in the assignment was to create an alternate, tidy dataset with the average of each variable for each activity and each subject found in the *data_mean_SD* data frame.   This was done using the "plyr" package and the "ddply" function within plyr.  This new tidy data set was given the name *tidy_data* .
* The final step in the assignment was to write  the *tidy_data* data frame into a txt file.   This was done via the *write.table()* function:
```
write.table(tidy_data, file = "tidy_data.txt", sep = "\t", row.names = FALSE)
```
* The *tidy_data* data frame now consisted of 180 observations of 88 variables.   The 180 observations consist of the 30 different subjects (as noted in SubjectID) across the 6 different Activities (as noted in the ActivityName ).   The 88 variable names consisted of the following:

```
 names(tidy_data)
 [1] "SubjectID"                                                             
 [2] "ActivityName"                                                          
 [3] "Average time_Body_Acceleration_Mean_X"                                 
 [4] "Average time_Body_Acceleration_Mean_Y"                                 
 [5] "Average time_Body_Acceleration_Mean_Z"                                 
 [6] "Average time_Body_Acceleration_Standard_Deviation_X"                   
 [7] "Average time_Body_Acceleration_Standard_Deviation_Y"                   
 [8] "Average time_Body_Acceleration_Standard_Deviation_Z"                   
 [9] "Average time_Gravity_Acceleration_Mean_X"                              
[10] "Average time_Gravity_Acceleration_Mean_Y"                              
[11] "Average time_Gravity_Acceleration_Mean_Z"                              
[12] "Average time_Gravity_Acceleration_Standard_Deviation_X"                
[13] "Average time_Gravity_Acceleration_Standard_Deviation_Y"                
[14] "Average time_Gravity_Acceleration_Standard_Deviation_Z"                
[15] "Average time_Body_Acceleration_Jerk_Mean_X"                            
[16] "Average time_Body_Acceleration_Jerk_Mean_Y"                            
[17] "Average time_Body_Acceleration_Jerk_Mean_Z"                            
[18] "Average time_Body_Acceleration_Jerk_Standard_Deviation_X"              
[19] "Average time_Body_Acceleration_Jerk_Standard_Deviation_Y"              
[20] "Average time_Body_Acceleration_Jerk_Standard_Deviation_Z"              
[21] "Average time_Body_Gyro_Mean_X"                                         
[22] "Average time_Body_Gyro_Mean_Y"                                         
[23] "Average time_Body_Gyro_Mean_Z"                                         
[24] "Average time_Body_Gyro_Standard_Deviation_X"                           
[25] "Average time_Body_Gyro_Standard_Deviation_Y"                           
[26] "Average time_Body_Gyro_Standard_Deviation_Z"                           
[27] "Average time_Body_Gyro_Jerk_Mean_X"                                    
[28] "Average time_Body_Gyro_Jerk_Mean_Y"                                    
[29] "Average time_Body_Gyro_Jerk_Mean_Z"                                    
[30] "Average time_Body_Gyro_Jerk_Standard_Deviation_X"                      
[31] "Average time_Body_Gyro_Jerk_Standard_Deviation_Y"                      
[32] "Average time_Body_Gyro_Jerk_Standard_Deviation_Z"                      
[33] "Average time_Body_Acceleration_Magnitude_Mean_"                        
[34] "Average time_Body_AccelerationMag_Standard_Deviation_"                 
[35] "Average time_Gravity_Acceleration_Magnitude_Mean_"                     
[36] "Average time_Gravity_AccelerationMag_Standard_Deviation_"              
[37] "Average time_Body_Acceleration_Jerk_Magnitude_Mean_"                   
[38] "Average time_Body_Acceleration_JerkMag_Standard_Deviation_"            
[39] "Average time_Body_Gyro_Magnitude_Mean_"                                
[40] "Average time_Body_GyroMag_Standard_Deviation_"                         
[41] "Average time_Body_Gyro_Jerk_Magnitude_Mean_"                           
[42] "Average time_Body_Gyro_JerkMag_Standard_Deviation_"                    
[43] "Average frequency_Body_Acceleration_Mean_X"                            
[44] "Average frequency_Body_Acceleration_Mean_Y"                            
[45] "Average frequency_Body_Acceleration_Mean_Z"                            
[46] "Average frequency_Body_Acceleration_Standard_Deviation_X"              
[47] "Average frequency_Body_Acceleration_Standard_Deviation_Y"              
[48] "Average frequency_Body_Acceleration_Standard_Deviation_Z"              
[49] "Average frequency_Body_Acceleration_Mean_Frequency_X"                  
[50] "Average frequency_Body_Acceleration_Mean_Frequency_Y"                  
[51] "Average frequency_Body_Acceleration_Mean_Frequency_Z"                  
[52] "Average frequency_Body_Acceleration_Jerk_Mean_X"                       
[53] "Average frequency_Body_Acceleration_Jerk_Mean_Y"                       
[54] "Average frequency_Body_Acceleration_Jerk_Mean_Z"                       
[55] "Average frequency_Body_Acceleration_Jerk_Standard_Deviation_X"         
[56] "Average frequency_Body_Acceleration_Jerk_Standard_Deviation_Y"         
[57] "Average frequency_Body_Acceleration_Jerk_Standard_Deviation_Z"         
[58] "Average frequency_Body_Acceleration_Jerk_Mean_Frequency_X"             
[59] "Average frequency_Body_Acceleration_Jerk_Mean_Frequency_Y"             
[60] "Average frequency_Body_Acceleration_Jerk_Mean_Frequency_Z"             
[61] "Average frequency_Body_Gyro_Mean_X"                                    
[62] "Average frequency_Body_Gyro_Mean_Y"                                    
[63] "Average frequency_Body_Gyro_Mean_Z"                                    
[64] "Average frequency_Body_Gyro_Standard_Deviation_X"                      
[65] "Average frequency_Body_Gyro_Standard_Deviation_Y"                      
[66] "Average frequency_Body_Gyro_Standard_Deviation_Z"                      
[67] "Average frequency_Body_Gyro_Mean_Frequency_X"                          
[68] "Average frequency_Body_Gyro_Mean_Frequency_Y"                          
[69] "Average frequency_Body_Gyro_Mean_Frequency_Z"                          
[70] "Average frequency_Body_Acceleration_Magnitude_Mean_"                   
[71] "Average frequency_Body_AccelerationMag_Standard_Deviation_"            
[72] "Average frequency_Body_Acceleration_Magnitude_Mean_Frequency_"         
[73] "Average frequency_Body_BodyAcceleration_Jerk_Magnitude_Mean_"          
[74] "Average frequency_Body_BodyAcceleration_JerkMag_Standard_Deviation_"   
[75] "Average frequency_Body_BodyAcceleration_Jerk_Magnitude_Mean_Frequency_"
[76] "Average frequency_Body_BodyGyro_Magnitude_Mean_"                       
[77] "Average frequency_Body_BodyGyroMag_Standard_Deviation_"                
[78] "Average frequency_Body_BodyGyro_Magnitude_Mean_Frequency_"             
[79] "Average frequency_Body_BodyGyro_Jerk_Magnitude_Mean_"                  
[80] "Average frequency_Body_BodyGyro_JerkMag_Standard_Deviation_"           
[81] "Average frequency_Body_BodyGyro_Jerk_Magnitude_Mean_Frequency_"        
[82] "Average angle_time_Body_Acceleration_Mean,gravity"                     
[83] "Average angle_time_Body_Acceleration_Jerk_Mean,gravity_Mean"           
[84] "Average angle_time_Body_Gyro_Mean,gravity_Mean"                        
[85] "Average angle_time_Body_Gyro_Jerk_Mean,gravity_Mean"                   
[86] "Average angle_X,gravity_Mean"                                          
[87] "Average angle_Y,gravity_Mean"                                          
[88] "Average angle_Z,gravity_Mean"       
```




