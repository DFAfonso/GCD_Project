
## Course Project:  Getting and Cleaning Data

  
### Description

The purpose of this project is to collect, work with, and clean a data set.

The data for this project can be found here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


This represents data collected from the accelerometers from the Samsung Galaxy S smartphone.


### Repository Files

1. **README.md**: This file will explain scripts included in the repo (run_analysis.R in this case)
2. **CodeBook.md**: Information about the data, variable descriptions, and any work done to transform and/or clean up the data
3. **run_analysis.R**: R script to transform the given, raw data set into a tidy one (based on project requirements)
4. **tidy_data.txt**:  Tidy data set created by the run_analysis.R script file

### Script file implementation based on project requirements
The script file, *run_analysis.R* was required to perform the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


Details regarding functions called, variables used, etc... will be noted in the *CodeBook.md* file.


* The principle data files (X_train, y_train, subject_train, etc...) were read into R, and combined.   The variable names were obtained from the features.txt file and the activity names were pulled from the activity_labels.txt file.
* Further details will be found in the *Codebook.md* file, but the basic idea is well demonstrated via an image posted by Community TA, David Hood at:

https://class.coursera.org/getdata-007/forum/thread?thread_id=49


![](Slide2.png)


