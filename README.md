# Coursera course: 
## GetData: Getting and Cleaning Data Project 

A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Problem: You should create one R script called run_analysis.R that does the following.

	1. Merges the training and the test sets to create one data set.
	2. Extracts only the measurements on the mean and standard deviation for each measurement. 
	3. Uses descriptive activity names to name the activities in the data set
	4. Appropriately labels the data set with descriptive variable names. 
	5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Requirements: R must have following packages installed
	1. read.table # To read the tidy data
    2. plyr   # to aggregate data set 
    3. knitr  # To generate CodeBook.md

## Data Set:
   download the data set from above link, extract it and rename the folder *data*

How to use code:
    Run the program run_analysis.R in your RStudio or R console, before running program please check that directories and code are placed in proper way, in my 
    out of the following commands are
    > dir()
		[1] "CodeBook.html"  "CodeBook.md"   
		[3] "CodeBook.txt"   "LICENSE"       
		[5] "README.md"      "data"          
		[7] "run_analysis.R"
	> getwd()
		[1] "/Users/krishna/study/Coursera/DataSciences/GetData/GetData"
	> setwd("data")
	> dir()
		[1] "CodeBook.Rmd"        "README.txt"         
		[3] "activity_labels.txt" "features.txt"       
		[5] "features_info.txt"   "test"               
		[7] "tidydata.txt"        "train"              
	> setwd("../")
	> getwd()
		[1] "/Users/krishna/study/Coursera/DataSciences/GetData/GetData" 
	> source("run_analysis.R") # after above check, run this code it will write the tidy data set in data folder and also create CodeBook.md


	# Getting and Cleaning Data