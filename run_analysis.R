library(dplyr)
setwd("C:/Coursera_Temp/Assignment")
X_test <- read.table("X_test.txt") # read the test set data into a dataframe called X_test
X_train <- read.table("X_train.txt") # read the training set data into a dataframe called Y_test
features <- read.table("features.txt", as.is = TRUE) # read the list of features into a dataframe called columNames
test_activities <- read.table("y_test.txt") # read the activity associated with each row in X_test into a dataframe called test_activities
train_activities <- read.table("y_train.txt") #read the activity associated with each row in X_train into a dataframe called train_activities
test_subjects <- read.table("subject_test.txt") # read the subject ID's associated with each row in X_test into a dataframe called test_subjects
train_subjects <- read.table("subject_train.txt") # read the subject ID's associated with each row in X_train into a dataframe called train_subjects


numCols <- ncol(X_test) # get the number of columns in the X_test dataframe and assign it to numCols

for (i in 1:numCols){ # for each column in the X_test dataframe, rename the column to the corresponding feature in columNames
  colnames(X_test)[i] <- features[i,2]
}

for (i in 1:numCols){ # do the same for the X_train dataset - already confirmed that number of columns in X_train and Y_train are the same using str
  colnames(X_train)[i] <- features[i,2]
}


colnames(test_activities) <- "Activity_Type" # add column name to the first column of the test_activities dataframe
colnames(train_activities) <- "Activity_Type" # add column name to the first column of the test_activities dataframe

X_train2 <- cbind(train_activities, X_train) #add column 1 of the train_activities dataframe as the first column of the X_train dataframe
X_test2 <- cbind(test_activities, X_test) #add column 1 of the test_activities dataframe as the first column of the X_test dataframe

colnames(test_subjects) <- "Subject_ID" # add column name to the first column of the test_subjects dataframe
colnames(train_subjects) <- "Subject_ID" # add column name to the first column of the train_activities dataframe
# now each observation is associated with an activity

X_test3 <- cbind(test_subjects, X_test2)
X_train3 <- cbind(train_subjects, X_train2)
# now each observation is associated with both an activity and a subject ID

X_test4 <- cbind(test_subjects, X_test3) # add an extra subject_ID column on as a workaround
X_train4 <- cbind(train_subjects, X_train3) # add an extra subject_ID column on as a workaround

#combine X_test4 and x_train4 dataframes to gether into one

X_combined <- rbind(X_test4, X_train4)

X_combined2 <- X_combined[,-1] # this gets rid of the duplicate column name error, by getting rid of the
# first (extra) subject ID column, but why?

X_combined_subset <- select(X_combined2, Subject_ID, Activity_Type, contains("mean("), contains("std"))
# create a dataframe including only the Subject and Activity ID's + any columns that have mean or standard deviation values

numRows <- nrow(X_combined_subset) #get the number of rows in the X_combined_subset data frame

for(i in 1:numRows){ # for each row in X_combined_subset, replace the Activity ID with an Activity Name
  if(X_combined_subset[i, 2] == "1"){X_combined_subset[i, 2] <- "Walking"}
  else if(X_combined_subset[i, 2] == "2"){X_combined_subset[i, 2] <- "Walking_Up_Stairs"}
  else if(X_combined_subset[i, 2] == "3"){X_combined_subset[i, 2] <- "Walking_Down_Stairs"}
  else if(X_combined_subset[i, 2] == "4"){X_combined_subset[i, 2] <- "Sitting"}
  else if(X_combined_subset[i, 2] == "5"){X_combined_subset[i, 2] <- "Standing"}
  else {X_combined_subset[i, 2] <- "Laying"}
}

X_grouped_subset <- group_by(X_combined_subset, Subject_ID, Activity_Type)
#group the X_combined_subset dataframe by Subject_ID and Activity_Type)

final_tidy_data <- summarise_each(X_grouped_subset, funs(mean), `tBodyAcc-mean()-X`:`fBodyBodyGyroJerkMag-std()`)
#summarize the grouped data to display the average of each variable for each activity and each subject

write.table(final_tidy_data, "C:/Coursera_Temp/Assignment/Final_Tidy_Data.txt", row.name=FALSE)