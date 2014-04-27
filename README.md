GettingAndCleaningData1
=======================

A repo for the programming assignment for the Coursera Getting and Cleaning Data course

You should create one R script called run_analysis.R that does the following: 
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive activity names. 
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Instructions
* Load data into working directory in folder UCI HAR Dataset
* source('run_analysis.R')
* Be patient, this takes a while
* Output goes to output.txt as tab-delimited

#How it works
See comments in run_analysis.R for more detail, but in short:
* Merges the various files together in one dataset, sets up labels as factors
* Greps for variable names with '-mean()' and '-std()', redacts other columns
* Uses melt and dcast to create a new dataset of subject + activity ~ variable (means)