# Code Book for getting and cleaning data project assignment by Somprabh Jha 

## Raw Data

The raw data for this project is accelerometer data collected from the Samsung Galaxy S smartphone.
Data file: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
CodeBook: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

3 files were processed from both the test and train folders:
X: feature measurement data
y: the activity number corresponding to each row in X.
subject: the subject number corresponding to each row in X.

The features.txt file contained the feature names, measurement for which was present in X.

The activity_labels.txt mapped the activity number (in y) to a description.


## Output Data

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals timeaccelerometer-XYZ and 
timegyroscope-XYZ. 

These time domain signals were captured at a constant rate of 50 Hz. and the acceleration signal was then separated into body and 
gravity acceleration signals (timebodyaccelerometer-XYZ and timegravityaccelerometer-XYZ) – both using a low pass Butterworth filter.

The body linear acceleration and angular velocity were derived in time to obtain Jerk signals (timebodyaccelerometerjerk-XYZ and 
timebodygyroscopejerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm 
(timebodyaccelerometermagnitude, timegravityaccelerometermagnitude, timebodyaccelerometerjerkmagnitude, timebodygyroscopemagnitude, 
timebodygyroscopejerkmagnitude).

A Fast Fourier Transform (FFT) was applied to some of these signals producing frequencybodyaccelerometer-XYZ, 
frequencybodyaccelerometerjerk-XYZ, frequencybodygyroscope-XYZ, frequencybodyaccelerometerjerkmagnitude, 
frequencybodygyroscopemagnitude, frequencybodygyroscopejerkmagnitude. 

The units given are g’s for the accelerometer and rad/sec for the gyroscope and g/sec and rad/sec/sec for the corresponding jerks.

Only the mean and standard deviation (sd) measurements were used for the output data

The subject refers the the numeric value of the subject from whom the measurements were taken. The activitynum represents the numeric 
value of the activity being measured and the activityname reprsents the decription (from the activity_labels.txt file) of the activity 
being measured. 

The output data is the mean of all the measuments (of each column) grouped by subject and activityname

The following are the output columns
  subject
  activityname
  activitynum
  timebodyaccelerometermeanX
timebodyaccelerometermeanY
timebodyaccelerometermeanZ
timegravityaccelerometermeanX
timegravityaccelerometermeanY
timegravityaccelerometermeanZ
timebodyaccelerometerjerkmeanX
timebodyaccelerometerjerkmeanY
timebodyaccelerometerjerkmeanZ
timebodygyroscopemeanX
timebodygyroscopemeanY
timebodygyroscopemeanZ
timebodygyroscopejerkmeanX
timebodygyroscopejerkmeanY
timebodygyroscopejerkmeanZ
timebodyaccelerometermagnitudemean
timegravityaccelerometermagnitudemean
timebodyaccelerometerjerkmagnitudemean
timebodygyroscopemagnitudemean
timebodygyroscopejerkmagnitudemean
frequencybodyaccelerometermeanX
frequencybodyaccelerometermeanY
frequencybodyaccelerometermeanZ
frequencybodyaccelerometerjerkmeanX
frequencybodyaccelerometerjerkmeanY
frequencybodyaccelerometerjerkmeanZ
frequencybodygyroscopemeanX
frequencybodygyroscopemeanY
frequencybodygyroscopemeanZ
frequencybodyaccelerometermagnitudemean
frequencybodyaccelerometerjerkmagnitudemean
frequencybodygyroscopemagnitudemean
frequencybodygyroscopejerkmagnitudemean
timebodyaccelerometersdX
timebodyaccelerometersdY
timebodyaccelerometersdZ
timegravityaccelerometersdX
timegravityaccelerometersdY
timegravityaccelerometersdZ
timebodyaccelerometerjerksdX
timebodyaccelerometerjerksdY
timebodyaccelerometerjerksdZ
timebodygyroscopesdX
timebodygyroscopesdY
timebodygyroscopesdZ
timebodygyroscopejerksdX
timebodygyroscopejerksdY
timebodygyroscopejerksdZ
timebodyaccelerometermagnitudesd
timegravityaccelerometermagnitudesd
timebodyaccelerometerjerkmagnitudesd
timebodygyroscopemagnitudesd
timebodygyroscopejerkmagnitudesd
frequencybodyaccelerometersdX
frequencybodyaccelerometersdY
frequencybodyaccelerometersdZ
frequencybodyaccelerometerjerksdX
frequencybodyaccelerometerjerksdY
frequencybodyaccelerometerjerksdZ
frequencybodygyroscopesdX
frequencybodygyroscopesdY
frequencybodygyroscopesdZ
frequencybodyaccelerometermagnitudesd
frequencybodyaccelerometerjerkmagnitudesd
frequencybodygyroscopemagnitudesd
frequencybodygyroscopejerkmagnitudesd

## The transformation process

1. Download and unzip the input file.
2. Read the X_train, y_train and subject_train files to load data into corresponding data tables.
3. Assign column names to the 3 train data tables.
4. Merge (column bind) the 3 train data tables to create the train data table.
5. Read the X_test, y_test and subject_test files to load data into corresponding data tables.
6. Assign column names to the 3 test data tables.
7. Merge (column bind) the 3 test data tables to create the test data table.
8. Merge (row bind) the train and test data tables to create a data table containing all input data needed.
9. Build a variable and use it to select only the needed (subject, activitynum and all mean() & std()) variables from the data table from step 8.
10. Create a data table of activitynum and activityname (use activity_labels file).
11. Merge the data table from step 10 with the one from step 9.
12. Fix the variable names as per tidying rules.
13. Create a variable, to group the data table from step 12, by subject & activityname and calculate the mean for the other table variables.
14. Apply the variable, from step 13, on the data table from step 12 to create the final output data table.
15. Write the data table to an output file.

