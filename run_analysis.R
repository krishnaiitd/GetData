#### run_analysis.R ###
## You should create one R script called run_analysis.R that does the following. 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# From the data set in step 4, creates a second, independent tidy data 
# set with the average of each variable for each activity and each subject.

#### 1. Merges the training and the test sets to create one data set. ####

# Get the feature vector names: it is column names in training data set.
features <- read.table("./data/features.txt", header = FALSE)
#Get only feature column name
features <- features[, 2]

# Extracts only the measurements on the mean and standard deviation for each measurement.
required_features <- grepl("mean|std", features)

# Uses descriptive activity names to name the activities in the data set
activity_names <- read.table("./data/activity_labels.txt")[,2]

## Read the Training Data sets
subject_train <- read.table("./data/train/subject_train.txt", header = FALSE)
X_train <- read.table("./data/train/X_train.txt", header = FALSE)
y_train <- read.table("./data/train/y_train.txt", header = FALSE)
# Test that the data are correct or not: if the number of row in X_train & y_train not sampe then exit
if(nrow(X_train) != nrow(y_train)) {
  stop("Number of row in trainig data set should be as number of row in test data set")
}

# Appropriately labels the data set with descriptive variable names.
names(X_train) <- features
# Extracts only the measurements on the mean and standard deviation for each measurement.
X_train <- X_train[ , required_features]
# Uses descriptive activity names to name the activities in the data set
y_train[, 2] <- activity_names[y_train[,1]]
names(y_train) <- c("Activity_Id", "Activity_Label")
names(subject_train) <- "Subject"
# Bind the training data 
train_data <- cbind(as.data.frame(subject_train), y_train, X_train)


## Read the test data set
subject_test <- read.table("./data/test/subject_test.txt", header = FALSE)
X_test <- read.table("./data/test/X_test.txt", header = FALSE)
y_test <- read.table("./data/test/y_test.txt", header = FALSE)
# Test that the data are correct or not: if the number of row in X_train & y_train not sampe then exit
if(nrow(X_test) != nrow(y_test)) {
  stop("Number of row in trainig data set should be as number of row in test data set")
}

names(X_test) <- features
# Extracts only the measurements on the mean and standard deviation for each measurement.
X_test <- X_test[ , required_features]
# Uses descriptive activity names to name the activities in the data set
y_test[, 2] <- activity_names[y_test[,1]]
names(y_test) <- c("Activity_Id", "Activity_Label")
names(subject_test) <- "Subject"
# Bind the training data 
test_data <- cbind(as.data.frame(subject_test), y_test, X_test)

## Finally ;) Merges the training and the test sets to create one data set.
data <- rbind(train_data, test_data)
## Appropriately labels the data set with descriptive variable names
# replaced t with time
names(data)<-gsub("^t", "time", names(data))
# replaced f with frequency
names(data)<-gsub("^f", "frequency", names(data))
# replaced Acc with Accelerometer
names(data)<-gsub("Acc", "Accelerometer", names(data))
# replaced Gyro with Gyroscope
names(data)<-gsub("Gyro", "Gyroscope", names(data))
# replaced Mag with Magnitude
names(data)<-gsub("Mag", "Magnitude", names(data))
# replaced BodyBody with Body
names(data)<-gsub("BodyBody", "Body", names(data))

# Apply mean function to dataset using dcast function
library(plyr)
data <- aggregate(. ~Subject + Activity_Id, data, mean)
data <- data[order(data$Subject, data$Activity_Id), ]

write.table(data, file = "./data/tidydata.txt")

## Prepare the Codebook by using the library 'knitr'
library(knitr)
writeLines(names(data), "./data/CodeBook.Rmd")
knit2html("./data/CodeBook.Rmd")