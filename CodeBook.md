# Getting and Cleaning Data week 4 assignment
## Code Book

### The raw data

The source data are measurements from the embedded accelerometer and gyroscope of a Sumsung Galaxy SII worn
by 30 volunteers within an age range of 19-49 years. Each person performed six activities 

1. WALKING
1. WALKING_UPSTAIRS, 
1. WALKING_DOWNSTAIRS
1. SITTING
1. STANDING
1. LAYING

A full description of the source data is available at [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The dataset can be downloaded from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

The raw data consists of two machine learning datasets - a random 70% of the data is in the training set, the remainder in the test set.

Each dataset consists of 3 files.

1. X_test.txt and X_train.txt - contain the sensor measurements for each observation
2. y_test.txt and y_train.txt - contain the activity identifier for each observation
3. subject_test.txt, and subject_train.txt - contain the subject id for each observation

In addition metadata is available in these files

* activity_labels.txt maps activity indentifier to label
* features.txt contains the name of each variable in the X data

### The tidy output data

A dataset containg the average of each variable for each activity and each subject.

Only the variables for mean and std have been included

### Processing steps

1. Labels for the varaibles are read from features.txt. These are filtered so that only the mean and std variables remain and names are cleaned. This results in 48 variables.

1. The activity labels are read from activity_labels.txt and cleaned

1. Each data set is loaded and cleaned, 

  1. The required columns are selected
  1. Column names are assigned using the cleaned values from features.txt
  1. The activity column is assigned as a factor with the labels read from activity_labels.txt
  1. The subject column is assigned from the subject_*.txt file

1. The training and test datasets are merged
1. The resulting tidy dataset is reshaped to show the mean of each variable, broken down by subject and activity.

The dataset produced has: 
* 180 rows - 30 participants * 6 activities
* 50 columns - subject, activity + the 48 mean values

#####Citation:

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.

[UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)


