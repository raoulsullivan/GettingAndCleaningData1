#This script is for the Coursera Getting and Cleaning Data course.
#1) Merges the training and the test sets to create one data set.
#2) Extracts only the measurements on the mean and standard deviation for each 
#measurement. 
#3) Uses descriptive activity names to name the activities in the data set
#4) Appropriately labels the data set with descriptive activity names. 
#5) Creates a second, independent tidy data set with the average of each variable 
#for each activity and each subject. 

#Stephen Raoul Sullivan, 2014-04-27

#Assumes files are in folder 'UCI HAR Dataset' in the working directory
#Assumes the mean and standard deviation sets have '-mean()' or '-std()' in
#the column name
#Prints output to output.txt in the working directory

#We need the reshape2 library for the melt and dcast functions at the end
library(reshape2)

message("This will take a long time. Please be patient")

#Load two main datasets
train <- read.fwf('UCI HAR Dataset/train/X_train.txt',rep(16,561))
message("Done train, now for test. Please continue to be patient")
test <- read.fwf('UCI HAR Dataset/test/X_test.txt',rep(16,561))

message("Reading of big files over, shouldn't be long now")

#Load column names
features <- readLines('UCI HAR Dataset/features.txt')

#Apply these names to the datasets
colnames(train) <- sapply(features, function(x){strsplit(x," ")[[1]][2]})
colnames(test) <- sapply(features, function(x){strsplit(x," ")[[1]][2]})

#Load in activities
test$labels <- readLines('UCI HAR Dataset/test/y_test.txt')
train$labels <- readLines('UCI HAR Dataset/train/y_train.txt')

#Load in subjects
test$subject <- readLines('UCI HAR Dataset/test/subject_test.txt')
train$subject <- readLines('UCI HAR Dataset/train/subject_train.txt')

#Get the labels for the activities
factorlevels <- readLines('UCI HAR Dataset/activity_labels.txt')
pip <- lapply(factorlevels,function(x){strsplit(x," ")[[1]][2]})

#Apply these labels to the data
test$activity <- factor(test$labels, labels=pip)
train$activity <- factor(train$labels, labels=pip)

#Add a key for the test or train data, incase we need to separate these out in
#the future
test$type <- 2
train$type <- 1

#Merge the two data sets
total <- rbind(train,test)

#Add a factor variable for test or train because it's neater
total$typefactor <- factor(total$type,labels=c("train","test"))

#Find the target data
meancols <- grep("-mean()",colnames(total),fixed=T)
stdcols <- grep("-std()",colnames(total),fixed=T)

#Also the labels we added previously
extracols <- c(562:566)

allcols <- c(meancols,stdcols,extracols)

#Redact the dataset
redacteddata <- total[,allcols]

#Melt it, using the label columns as id variables
molten <- melt(redacteddata,c(67:71))

#Cast it, splitting by activity and subject per variable and taking the mean
output <- dcast(molten, subject + activity ~ variable , mean)

#Spit to text file
write.table(output,"output.txt",sep="\t")

message('All done')
output