# Getting and Cleaning Data Course Project
# by John Mara

#install packages and load libraries
install.packages("dplyr")
library(dplyr)

# read activity labels
activity_labels <- read.table("activity_labels.txt")
# rename variables
activity_labels <- rename(activity_labels,activity_number=V1,activity_name=V2)

# read features
features <- read.table("features.txt")
# rename variables
features <- rename(features,feature_number=V1,feature_name=V2)

# read train data
        # read training subjects
        train_subjects <- read.table("./train/subject_train.txt")
        # rename variables
        train_subjects <- rename(train_subjects,subject_number=V1)
        # add row number to use as key
        train_subjects$key <- 1:nrow(train_subjects)
        # read training activities
        train_activities <- read.table("./train/y_train.txt")
        # rename variables
        train_activities <- rename(train_activities,activity_number=V1)
        # add row number to use as key
        train_activities$key <- 1:nrow(train_activities)
        # merge activities with activity names
        train_activities <- merge(train_activities,activity_labels)
        # read training data
        train_data <- read.table("./train/X_train.txt")
        # add variable names to train data
        names(train_data) <- features[,2]
        # add row number to use as key
        train_data$key <- 1:nrow(train_data)
        # combine train activities and subjects
        train_details <- merge(train_activities,train_subjects,by="key")
        # add training data
        train_data2 <- merge(train_details,train_data,by="key")
        # only keep variable names that contain "mean"
        train_data_mean <- train_data2[, grep("*mean*", colnames(train_data))]
        # only keep variable names that contain "std"
        train_data_std <- train_data2[, grep("*std*", colnames(train_data))]
        # combine train datasets with mean and std into one dataset
        train_data3 <- cbind(train_data_mean,train_data_std)

# read test data
        # read testing subjects
        test_subjects <- read.table("./test/subject_test.txt")
        # rename variables
        test_subjects <- rename(test_subjects,subject_number=V1)
        # add row number to use as key
        test_subjects$key <- 1:nrow(test_subjects)
        # read testing activities
        test_activities <- read.table("./test/y_test.txt")
        # rename variables
        test_activities <- rename(test_activities,activity_number=V1)
        # add row number to use as key
        test_activities$key <- 1:nrow(test_activities)
        # merge activities with activity names
        test_activities <- merge(test_activities,activity_labels)
        # read testing data
        test_data <- read.table("./test/X_test.txt")
        # add variable names to test data
        names(test_data) <- features[,2]
        # add row number to use as key
        test_data$key <- 1:nrow(test_data)
        # combine test activities and subjects
        test_details <- merge(test_activities,test_subjects,by="key")
        # add testing data
        test_data2 <- merge(test_details,test_data,by="key")
        # only keep variable names that contain "mean"
        test_data_mean <- test_data2[, grep("*mean*", colnames(test_data))]
        # only keep variable names that contain "std"
        test_data_std <- test_data2[, grep("*std*", colnames(test_data))]
        # combine test datasets with mean and std into one dataset
        test_data3 <- cbind(test_data_mean,test_data_std)
        
# combine train and test data 
combined_data <- rbind(train_data3,test_data3)
# drop activity number and key
combined_data$activity_number <- NULL
combined_data$key <- NULL

# summarize data by taking average of all measures for each 
# unique combination of activity and subject
dataMelt <- melt(combined_data,id=c("activity_name","subject_number"))
head(dataMelt,n=3)
tail(dataMelt,n=3)
# final tidy data set
final_data <- dcast(dataMelt, activity_name + subject_number ~ variable,mean)
# output as text file 
write.table(final_data,"output.txt",row.name = FALSE)
