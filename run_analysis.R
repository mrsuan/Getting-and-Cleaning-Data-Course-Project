## Downloading data
if(!file.exists("./data")){dir.create("./data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile="./data/Dataset.zip", method="curl")

## Unzipping data
unzip(zipfile = "./data/Dataset.zip", exdir="./data")

path_rf <- file.path("./data", "UCI HAR Dataset")
files <- list.files(path_rf, recursive = TRUE)
files

## Reading data
ActivityTest  <- read.table(file.path(path_rf, "test", "Y_test.txt" ),header = FALSE)
ActivityTrain <- read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE)

SubjectTrain <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)
SubjectTest  <- read.table(file.path(path_rf, "test", "subject_test.txt"),header = FALSE)

FeaturesTest  <- read.table(file.path(path_rf, "test", "X_test.txt" ),header = FALSE)
FeaturesTrain <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)

## Looking the data
str(ActivityTest)
str(ActivityTrain)

str(SubjectTrain)
str(SubjectTest)

str(FeaturesTest)
str(FeaturesTrain)

## Merging data
Activity <- rbind(ActivityTrain, ActivityTest)
Subject <- rbind(SubjectTrain, SubjectTest)
Features <- rbind(FeaturesTrain, FeaturesTest)

## Naming variables
names(Subject) <- c("Subject")
names(Activity) <- c("Activity")
FeaturesNames <- read.table(file.path(path_rf, "features.txt"),head=FALSE)
names(Features)<- FeaturesNames$V2

## STEP 1: Merging all data into a dataframe
DataMerge <- cbind(Subject, Activity)
Data <- cbind(Features, DataMerge)

## STEP 2: Extracts only the measurements on the mean and standard deviation for 
## each measurement

subdataFeaturesNames <- FeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", FeaturesNames$V2)]
selectedNames <- c(as.character(subdataFeaturesNames), "Subject", "Activity")
Data <- subset(Data, select = selectedNames)

str(Data)

## STEP 3: Uses descriptive activity names to name the activities in the data set
activityLabels <- read.table(file.path(path_rf, "activity_labels.txt"),header = FALSE)
Data$Activity <- activityLabels[Data$Activity, 2]
head(Data$Activity,30)

## STEP 4: Appropriately labels the data set with descriptive variable names
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

names(Data)

## STEP 5: Creates a second, independent tidy data set with the average of each 
## variable for each activity and each subject.
library(plyr);
Data2 <- aggregate(. ~Subject + Activity, Data, mean)
Data2 <- Data2[order(Data2$Subject,Data2$Activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)