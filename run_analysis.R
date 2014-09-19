####################################################################################################################
#  This is the run_analysis.R script file for the "Getting and Cleaning Data" course project on Coursera
#  
#  Instructions - Create one R script called run_analysis.R that does the following:
#   
#  1. Merges the training and the test sets to create one data set.
#  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#  3. Uses descriptive activity names to name the activities in the data set
#  4. Appropriately labels the data set with descriptive variable names. 
#  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
#     for each activity and each subject.
#
####################################################################################################################



# Assigning a variable to the string of the URL where the data for the project can be found

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Download file as data.zip into current working directory for R
download.file(fileURL, "data.zip")

# Unzips the file
unzip("data.zip") 

# Unzipping the file in R's working directory results in  the creation of a "UCI HAR Dataset" subdirectory.
# This directory has multiple files within it as well as two subdirectories, "test" & "train".  These themselves 
# have multiple files and a further subdirectory (in each) called "Inertial Signals".


## Load in the Raw Data with read.table

# Read in the activity labels and features:

activity_Labels <- read.table("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE) # Links labels with activity name
features <- read.table("UCI HAR Dataset/features.txt", sep="", header=FALSE, stringsAsFactors = FALSE) # List of all features

# Read in the training data:

train_x <-  read.table("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE) # Training Set
train_y <-  read.table("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE) # Training Labels
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE) # Subject(s) who trained

# Read in the testing data:
 
test_x <-  read.table("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE) # Test Set
test_y <-  read.table("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE) # Test Labels
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE) # Subject(s) who tested

####################################################################################################################
##  1. Merge the training and the test sets to create one data set.
####################################################################################################################

# Merge Training
training_data <- cbind(train_x, train_y)
training_data <- cbind(training_data, train_subject)

# Merge Testing
testing_data <- cbind(test_x,test_y)
testing_data <- cbind(testing_data, test_subject)

# Merge training data with testing data to have a complete data set
complete_data <- rbind(training_data, testing_data)

# Column labels of the complete data set are currently generic (ie - "V1","V2", ...,"V561", "V1", "V1") and
# will be changed as per the data read in from the features.txt file.   The only exceptions to this are the last
# two columns, which were read in from the "Y" files (the activity label) and the "subject" files.   These
# will be given appropriate column names.

column_Names <- rbind(features, c(562, "ActivityID")) # as this will be the 562nd row
column_Names <- rbind(column_Names, c(563, "SubjectID")) # as this will be the 563rd row

names(complete_data) <- column_Names[,2]  


####################################################################################################################
##  2. Extract only the measurements on the mean and standard deviation for each measurement.
####################################################################################################################


# A new data variable was created containing only the mean and standard deviation of the measurements
# The ignore.case argument was used in the grepl function, as there were some instances of both "mean" and "Mean"
# in the data.  "ActivityID" and "SubjectID" were also included to ensure they weren't dropped off from the search.

data_mean_SD <- complete_data[,grepl("mean|std|ActivityID|SubjectID", names(complete_data), ignore.case = TRUE)]


####################################################################################################################
##  3. Use descriptive activity names to name the activities in the data set
####################################################################################################################

# The activity names from the activity_labels.txt file (read in previously) will now be used - as the values in the 
# first column of activity_Labels correspond to the "ActivityID" column in the data set.  The "merge" function will 
# then be called.

names(activity_Labels) <- c("ActivityID", "ActivityName")
data_mean_SD <- merge(activity_Labels,data_mean_SD)


####################################################################################################################
##  4. Appropriately label the data set with descriptive variable names. 
####################################################################################################################

# The gsub function will be called in order to provide more "user-friendly" and descriptive column names.
# Based on the information provided in the features_info.txt file (provided in the zip file downloaded):
# t - refers to time domain signals
# f - refers to frequency domain signals

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


####################################################################################################################
##  5. From the data set in step 4, create a second, independent tidy data set with the average of each variable 
##     for each activity and each subject.
####################################################################################################################

# This will be completed with the ddply function from the plyr package
# numcolwise is also applied as it allows for mean to be applied to a column of the data.frame (instead of a vector)

library(plyr)

tidy_data <- ddply(.data = data_mean_SD, c("SubjectID", "ActivityName"),  numcolwise(mean))

# Update the column names
names(tidy_data) <- paste(rep("Average", length(names(tidy_data))),names(tidy_data))
names(tidy_data)[c(1,2)] <- c("SubjectID", "ActivityName")
tidy_data[,3] <- NULL

# Write the tidy dataset to a .txt file - in this case tab-delimited
write.table(tidy_data, file = "tidy_data.txt", sep = "\t", row.names = FALSE)


print(tidy_data)

