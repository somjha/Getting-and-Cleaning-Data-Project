###0. Prep Work.
###Load required packages
library(dplyr)
library(data.table)
library(tidyr)


###Download the Data
filesPath <- "D:/DataScience"
setwd(filesPath)
if(!file.exists("./CleaningDataAssignment")){dir.create("./CleaningDataAssignment")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./CleaningDataAssignment/Dataset.zip", method="curl")

###Unzip DataSet to /data directory
unzip(zipfile="./CleaningDataAssignment/Dataset.zip", exdir="./CleaningDataAssignment")


###1. Merge the training and test sets to create one data set.
filesPath <- "D:/DataScience/CleaningDataAssignment/UCI HAR Dataset"
# Read train subject, activity and data files
subjecttrain <- tbl_df(read.table(file.path(filesPath, "train", "subject_train.txt")))
activitytrain <- tbl_df(read.table(file.path(filesPath, "train", "Y_train.txt")))
datatrain <- tbl_df(read.table(file.path(filesPath, "train", "X_train.txt" )))

# Assign column names to the train data table
setnames(subjecttrain, "V1", "subject")
setnames(activitytrain, "V1", "activitynum")
datacolumns <- tbl_df(read.table(file.path(filesPath, "features.txt")))
setnames(datacolumns, names(datacolumns), c("featurenum", "featurename"))
colnames(datatrain) <- datacolumns$featurename

# Merge train columns to create train data table
subjectactivitytrain <- cbind(subjecttrain, activitytrain)
trainfull <- cbind(subjectactivitytrain, datatrain)

# Read test subject, activity and data files
subjecttest <- tbl_df(read.table(file.path(filesPath, "test", "subject_test.txt" )))
activitytest <- tbl_df(read.table(file.path(filesPath, "test", "Y_test.txt" )))
datatest <- tbl_df(read.table(file.path(filesPath, "test", "X_test.txt" )))

# Assign column names to the test data table
setnames(subjecttest, "V1", "subject")
setnames(activitytest, "V1", "activitynum")
colnames(datatest) <- datacolumns$featurename

# Merge test columns to create test data table
subjectactivitytest <- cbind(subjecttest, activitytest)
testfull <- cbind(subjectactivitytest, datatest)

#Merge the training and test data table rows to create a single merged data table
testtrainfull <- rbind(testfull, trainfull)


###2. Extract only the measurements on the mean and standard deviation for each measurement.
# Reading "features.txt" and preparing variable to select only the mean and standard deviation
datafeaturesmeanstd <- grep("mean\\(\\)|std\\(\\)", datacolumns$featurename, value=TRUE) 

# Adding "subject" and "activitynum" to the selected list of columns
datafeaturesmeanstd <- union(c("subject", "activitynum"), datafeaturesmeanstd)

# Selecting only the required columns to create new required data table
testtrainmeanstd <- subset(testtrainfull, select=datafeaturesmeanstd) 


###3. Use descriptive activity names to name the activities in the data set
#column names for activity labels
activitylabels <- tbl_df(read.table(file.path(filesPath, "activity_labels.txt")))
setnames(activitylabels, names(activitylabels), c("activitynum", "activityname"))

##enter name of activity into output data table
testtrainmeanstd <- merge(activitylabels, testtrainmeanstd, by="activitynum", all.x=TRUE)
testtrainmeanstd$activityname <- as.character(testtrainmeanstd$activityname)


###4. Appropriately labels the data set with descriptive variable names.
names(testtrainmeanstd) <- gsub("std()", "sd", names(testtrainmeanstd))
names(testtrainmeanstd) <- gsub("mean()", "mean", names(testtrainmeanstd))
names(testtrainmeanstd) <- gsub("^t", "time", names(testtrainmeanstd))
names(testtrainmeanstd) <- gsub("^f", "frequency", names(testtrainmeanstd))
names(testtrainmeanstd) <- gsub("Acc", "accelerometer", names(testtrainmeanstd))
names(testtrainmeanstd) <- gsub("Gyro", "gyroscope", names(testtrainmeanstd))
names(testtrainmeanstd) <- gsub("Mag", "magnitude", names(testtrainmeanstd))
names(testtrainmeanstd) <- gsub("BodyBody", "body", names(testtrainmeanstd))
names(testtrainmeanstd) <- gsub("Jerk", "jerk", names(testtrainmeanstd))
names(testtrainmeanstd) <- gsub("Gravity", "gravity", names(testtrainmeanstd))
names(testtrainmeanstd) <- gsub("Body", "body", names(testtrainmeanstd))
names(testtrainmeanstd) <- gsub("[^[:alnum:]]", "", names(testtrainmeanstd))


###5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## create data table with variable means sorted by subject and activityname
dataaggr <- aggregate(. ~ subject - activityname, data = testtrainmeanstd, mean) 
testtrainmeanstd <- tbl_df(arrange(dataaggr, subject, activityname))

##write to text file on disk
write.table(testtrainmeanstd, "TidyData.txt", row.name=FALSE)