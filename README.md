# Getting and Cleaning Data: Course Project
This repository contains my work on the course project for the Coursera course, Getting and Cleaning Data. 
Notes on the original dataset is follows below

# About the data source
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 

A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The repository includes the following files:
=========================================

- 'README.md'
- 'run_analysis.R': This R script does the following:
  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  3. Uses descriptive activity names to name the activities in the data set
  4.  Appropriately labels the data set with descriptive variable names. 
  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
- 'tidydata.txt': Contains the tidy data which is the output from 'run_analysis.R'
- 'CodeBook.md': The code book describes each variable in the dataset
