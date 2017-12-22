# Getting and cleanning data final project

This is the course project for the Getting and Cleaning Data Coursera course. The R script, run_analysis.R, does the following:

1. Download and unzip the dataset from(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) if it does not already exist in the working directory
2. Merges the train and test datasets using the readfile function.
3. Load the activity and feature info
3. Keeping only those features columns which reflect a mean or standard deviation
4. Uses descriptive activity names to name the activities in the data set
5. Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
The end result is shown in the file tidydata.txt.