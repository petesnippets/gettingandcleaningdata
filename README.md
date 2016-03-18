# Gettting and Cleaning Data

Submission for week 4 of Coursera course.

## Author

Pete Goddard

## Instructions

clone this repository and setwd() to it

```R
source("run_analysis.R")

runAnalysis("tidy-data.txt")
```

this will output the processed data to the specified file.

## How it works

1. ensureDataDownloaded() is called - this downloads if necccessary to ./data
1. getTidyData() is called. This collects some metadata and then
  1. calls loadMergeAndCleanData() for each of the 'train' and 'test' datasets. This in turn
    1. Loads the X_ values and selects the columns we need from each
    1. Names the columns
    1. loads the y values (the activity) and maps to a factor in the $activity column
    1. loads the subject ids and assigns them to the $subject column
    
    This results in clean data in a consistent format, ready to merge
  1. rbinds the results
1. The resulting data is passed to avgBySubjectAndActivity() which reshapes the data into mean by subject and activity
1. The finished data set is saved to the specified file name

