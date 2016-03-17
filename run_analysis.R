library(dplyr)
library(reshape2)

## Read the activity names, clean them and return as a character vector
getCleanActivityNames <- function(dataDir){
    read.table(paste0(dataDir, "/activity_labels.txt"))[,2] %>%
        gsub("_", " ", .)
}

## Read the feature labels from features.txt, clean them,
## filter only those for mean() ans std()
## return index and name in a data frame
getCleanMeanAndStdLabels <- function(dataDir){

    ## Cleans the names by removing parentheses, hyphens 
    ## and convert to lower case
    cleanUpNames <- function(x){
        x %>% 
            gsub("\\(\\)", "", .) %>%
            gsub("-", "_", .) %>%
            tolower
    }

    labels <- read.table(paste0(dataDir, "/features.txt"), sep = " ") 
    names(labels) <- c("index", "name")
    meanAndStdOnly <- labels[grep("-mean.{2}-|-std.{2}-", labels$name),]
    meanAndStdOnly$name <- cleanUpNames(meanAndStdOnly$name)
    meanAndStdOnly
}

## Load the sensor data from the X_ data file
## selects the supplied columns from the data
## assigns the supplied names to the columns
## Loads and merges data$activity as a factor with supplied activityNames
## Loads and merges data$subject 
## parameters
##  dataSetName : "test" or "train" to identify the data set
##  columns : an integer containing the columns numbers we want
##  names : the new names for the columns we want
##  activityNames : the labels for converting the activity into a factor
## returns
##  tidy data frame for the specified data set
loadMergeAndCleanData <- function(dataDir, dataSetName, columns, names, activityNames){
    #Read the X values
    xValueFilePath <- paste0(dataDir, "/", dataSetName, "/X_", dataSetName,  ".txt")
    data <- read.table(xValueFilePath, header = FALSE)[,columns] #only the specified columns
    
    names(data) <- names #name the selected columns
    
    #read the y values and assign to data$activity encoded as a factor
    yValueFilePath <- paste0(dataDir, "/", dataSetName, "/y_", dataSetName,  ".txt")
    yVals <- read.table(yValueFilePath, header = FALSE)
    data$activity <- factor(yVals$V1, labels = activityNames)
    
    #read the subject id data from file and assign to data$subject
    subjectFilePath <- paste0(dataDir, "/", dataSetName, "/subject_", dataSetName,  ".txt")
    subjects <- read.table(subjectFilePath)
    data$subject <- subjects$V1
    data
}

## load, merge, tidy and return the data from the training and test sets
getTidyData <- function(dataDir){
    labels <- getCleanMeanAndStdLabels(dataDir)
    
    activityNames <- getCleanActivityNames(dataDir)
    
    rbind(loadMergeAndCleanData(dataDir, "train", labels$index, labels$name, activityNames),
          loadMergeAndCleanData(dataDir, "test", labels$index, labels$name, activityNames))
}

## summarises the mean values for all observations of each feature by subject and activity
avgBySubjectAndActivity <- function(data){
    melt(data, id=c("subject", "activity")) %>%
        dcast(subject + activity ~ variable, mean)
}

## run the analysis and output the tidy dataset to a file
## parameters
##   dataDir: the directory containing the unzipped raw data
##   fileName: the name of the output file
runAnalysis <- function(dataDir, fileName){
    write.table(avgBySubjectAndActivity(getTidyData(dataDir)), file = fileName, row.names = FALSE)
}

