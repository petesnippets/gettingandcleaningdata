# Author: Pete Goddard

# Getting and cleaning data week 4 project

library(dplyr)
library(reshape2)
dataDir <- "./data"

## Read the activity names, clean them and return as a character vector
getCleanActivityNames <- function(){
    read.table(paste0(dataDir, "/activity_labels.txt"))[,2] %>%
        gsub("_", " ", .)
}

## Read the feature labels from features.txt, clean them,
## filter only those for mean() ans std()
## return index and name in a data frame
getCleanMeanAndStdLabels <- function(){

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

## Downloads the data if it does not exist
ensureDataDownloaded <- function(){
    if (!file.exists(dataDir)){
        message("downloading data")
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "./data.zip")
        unzip( "./data.zip")
        file.rename("UCI HAR Dataset", "data")
        file.remove("./data.zip")
    }
    else{
        message("data already downloaded")
    }
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
loadMergeAndCleanData <- function(dataSetName, columns, names, activityNames){
    message(paste("loading data for", dataSetName))
    xValueFilePath <- paste0(dataDir, "/", dataSetName, "/X_", dataSetName,  ".txt")
    data <- read.table(xValueFilePath, header = FALSE)[,columns] #only the specified columns
    
    names(data) <- names #name the selected columns
    
    #read the y values and assign to data$activity encoded as a factor
    yValueFilePath <- paste0(dataDir, "/", dataSetName, "/y_", dataSetName,  ".txt")
    message(paste("adding activity for", dataSetName))
    yVals <- read.table(yValueFilePath, header = FALSE)
    data$activity <- factor(yVals$V1, labels = activityNames)
    
    #read the subject id data from file and assign to data$subject
    subjectFilePath <- paste0(dataDir, "/", dataSetName, "/subject_", dataSetName,  ".txt")
    message(paste("adding subject for", dataSetName))
    subjects <- read.table(subjectFilePath)
    data$subject <- subjects$V1
    data
}

## load, merge, tidy and return the data from the training and test sets
getTidyData <- function(){
    labels <- getCleanMeanAndStdLabels()
    
    activityNames <- getCleanActivityNames()
    
    rbind(loadMergeAndCleanData("train", labels$index, labels$name, activityNames),
          loadMergeAndCleanData("test", labels$index, labels$name, activityNames))
}

## summarises the mean values for all observations of each feature by subject and activity
avgBySubjectAndActivity <- function(data){
    message("reshaping data by subject and activity")
    melt(data, id=c("subject", "activity")) %>%
        dcast(subject + activity ~ variable, mean)
}

## run the analysis and output the tidy dataset to a file
## parameters
##   fileName: the name of the output file
runAnalysis <- function(fileName){
    ensureDataDownloaded()
    data <- getTidyData()
    tidy <- avgBySubjectAndActivity(data)
    message(paste("writing to file", fileName))
    write.table(tidy, file = fileName, row.names = FALSE)
}

