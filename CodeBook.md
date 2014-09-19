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





