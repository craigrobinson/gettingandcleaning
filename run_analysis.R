## Instructions
# You should create one R script called run_analysis.R that does the following. 
#
#  1. Merges the training and the test sets to create one data set.
#    Assigning the column names also to keep it clean.
#  2. Extracts only the measurements on the mean and standard deviation for each measurement.
require(dplyr)
featuresFile <- read.table("./UCI HAR Dataset/features.txt")
featureNames <- as.vector(featuresFile[,2])
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names=c("activityID","activityName"))

# Combined these commands to avoid taking memory on temporary/duplicate storage of these data frames.
#  Went ahead and subsetted to the desired mean and std columns while reading to avoid taking up memory long term.
# For troubleshooting or other purposes, this could be deconstructed.
combinedData <- rbind(cbind(read.table("./UCI HAR Dataset/test/subject_test.txt", col.names="subjectID"),
                            read.table("./UCI HAR Dataset/test/Y_test.txt", col.names="activityID"),
                            subset(read.table("./UCI HAR Dataset/test/X_test.txt", col.names=featureNames),
                                   select = which(grepl("mean()|std()", featureNames, perl=T))
                                   )
                           ),
                      cbind(read.table("./UCI HAR Dataset/train/subject_train.txt", col.names="subjectID"),
                            read.table("./UCI HAR Dataset/train/Y_train.txt", col.names="activityID"),
                            subset(read.table("./UCI HAR Dataset/train/X_train.txt", col.names=featureNames),
                                   select = which(grepl("mean()|std()", featureNames, perl=T))
                                   )
                            )
                      )
#  3. Uses descriptive activity names to name the activities in the data set
combinedData <- merge(activityLabels, combinedData, by="activityID")
#  4. Appropriately labels the data set with descriptive variable names.
##   already assigned the labels provided in the features.txt file that are descriptive.
##   CodeBook will explain more based on features_info.txt. 
#  5. From the data set in step 4, creates a second, independent tidy data set with the average
#     of each variable for each activity and each subject.
tidyData <- combinedData %>%
             group_by (activityID, activityName, subjectID) %>%
             summarise_each (funs(mean))

write.table(tidyData, file="./tidydata.txt", row.name=FALSE)
