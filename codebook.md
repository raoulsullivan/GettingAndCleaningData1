#Codebook for submission to Coursera Getting and Cleaning Data course.
Stephen Raoul Sullivan, 2014-04-27

##Variables
There are no variables used in this exercise - it simply transforms the provided
dataset

##Data
This uses the provided data from the course.
The files used are:
* Training data
 * UCI HAR Dataset/train/X_train.txt
  * The data
 * UCI HAR Dataset/train/y_train.txt
  * The activities
 * UCI HAR Dataset/train/subject_train.txt
  * The subjects
* Test data
 * UCI HAR Dataset/test/X_test.txt
 * UCI HAR Dataset/test/y_test.txt
 * UCI HAR Dataset/test/subject_test.txt
* Data column names
 * UCI HAR Dataset/features.txt
* Activity labels
 * UCI HAR Dataset/activity_labels.txt

##Transformations
Transformations applied are as follows:
* Data joined together into one dataset
* Data points ending in '-mean()' and '-std()' used (33 of each) - all others redacted
* Data melted with melt()
* Data cast with dcast(), cast by subject and activity per variable, taking the means

##Output
Output is a data frame with 180 observances (30 subjects * 6 activities) and 68 variables (mean and std for each of 33 variables, plus subject and activity labels)
The values are the mean of the readings