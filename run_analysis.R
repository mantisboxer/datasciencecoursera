# start by loading necessary libraries

library(dplyr)
library(tidyr)

# now create some file pointers to keep everything straight

testdata <- "test/X_test.txt"
testsubjects <- "test/subject_test.txt"
testlabels <- "test/y_test.txt"
traindata <- "train/X_train.txt"
trainsubject <- "train/subject_train.txt"
trainlabels <- "train/y_train.txt"
features <- "features.txt"
labels <- "activity_labels.txt"

# create data identification structures

data_features <- read.table(features, col.names = c("featureID","featureName"))
featureNames <- paste(data_features$featureID,data_features$featureName,sep = "_") #correct feature names
ItemsOfInterest <- grep("*-(mean|std)\\(\\)-*",featureNames)
data_labels <- read.table(labels, col.names = c("activityID","activityName"))
train_labels <- read.table(trainlabels,col.names = "activityID")
test_labels <- read.table(testlabels,col.names = "activityID")
train_subj <- read.table(trainsubject, col.names = "subjects")
test_subj <- read.table(testsubjects,col.names = "subjects")

# read training file and add header names from data_features

train_data <- tbl_df(read.table(traindata))
names(train_data) <- featureNames

# extract columns of interest and attach subjects and labels

train_data <- train_data %>% select(ItemsOfInterest) 
train_data$subjects <- train_subj$subjects
train_data$activityID <- train_labels$activityID

# add dataset names
  
train_data$setID <- "training"

# repeat process on test file

test_data <- tbl_df(read.table(testdata))
names(test_data) <- featureNames
test_data <- test_data %>% select(ItemsOfInterest) 
test_data$subjects <- test_subj$subjects
test_data$activityID <- test_labels$activityID
test_data$setID <- "test"

# stack training and test data

full <- rbind(train_data,test_data)

# add activity names to the mix

full <- merge(full,data_labels,by.x = "activityID", by.y = "activityID", all.x = TRUE)

# make it readable

full <- select(full,setID,subjects,activityID, activityName,2:67)

# build statistics table

stats <- full %>% group_by(activityName,subjects) %>% select(activityName,subjects,5:70) %>% summarize_each(funs(mean))