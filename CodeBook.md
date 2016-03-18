# Getting and Cleaning Data 
  week 4 assignment

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

#### Note

Each feature is normalised to the range -1:1 so units are not relevant as original units have been lost during the normalisation.

### The tidy output data

A dataset containg the average of each variable for each activity and each subject.

Only the variables for mean and std have been included

#### Fields in the tidy data

The following sensor data is available in the source dataset

* tBodyAcc
* tGravityAcc
* tBodyAccJerk
* tBodyGyro
* tBodyGyroJerk
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc
* fBodyAccJerk
* fBodyGyro
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

Each of these sensors is respresented in the following fields: 
* mean()-X
* mean()-Y
* mean()-Z
* std()-X
* std()-Y
* std()-Z

The fields were filtered so that only fetures containing mean() and std() were selected

The measurment means are output in columns with this format 'tbodyacc_mean_x' and the standard deviation as 'tbodyacc_std_x' etc.

the following data fields for each sensor are not used and are not included in the tidy data:


* mad(): Median absolute deviation 
* max(): Largest value in array
* min(): Smallest value in array
* sma(): Signal magnitude area
* energy(): Energy measure. Sum of the squares divided by the number of values. 
* iqr(): Interquartile range 
* entropy(): Signal entropy
* arCoeff(): Autorregresion coefficients with Burg order equal to 4
* correlation(): correlation coefficient between two signals
* maxInds(): index of the frequency component with largest magnitude
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency
* skewness(): skewness of the frequency domain signal 
* kurtosis(): kurtosis of the frequency domain signal 
* bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
* angle(): Angle between to vectors.

the following source fields are also not used

* gravityMean
* tBodyAccMean
* tBodyAccJerkMean
* tBodyGyroMean
* tBodyGyroJerkMean

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
* 50 columns - subject, activity + the 48 mean or std values

#####Citation:

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.

[UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)


