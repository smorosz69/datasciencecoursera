#Data Science class from John Hopkins University via Coursera
#Student: Steve Orosz
#Purpose: Demonstration of skills learned in Getting and Cleaning data course
#Date: March 22, 2018

#You should create one R script called run_analysis.R that does the following.

#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement.
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names.
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each 
#activity and each subject.

#Link to information on data and source
#http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

#--------------------------Libraries to include----------------------------------------------------------
library(dplyr)


#---------------------------Check and set working directory----------------------------------------------
#Check working directory
getwd()

#Set working directory if necessary
setwd("C:/Users/Steve/Desktop/Data Science/Data Science - John Hopkins University Coursera/Getting and Cleaning Data/Week 4")



#----------------------Download and unzip files-----------------------------------------------------------

#Download project files
UrlLink <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

str(UrlLink)

#download(UrlLink, dest="dataset.zip", mode="wb") 
#unzip ("dataset.zip", exdir = "./")

#temp <- tempfile()
#download.file(UrlLink, destfile = "dataset.zip",temp)
download.file(UrlLink,"week_four_project")

#Record date zip file downloaded
downLoadDate <- date()
downLoadDate # "Thu Mar 22 15:32:10 2018"




#-------------------Read in activity and feature data files-----------------------------------------

#Get files for activities and features
activityLabels <- read.table("C:/Users/Steve/Desktop/Data Science/Data Science - John Hopkins University Coursera/Getting and Cleaning Data/Week 4/UCI HAR Dataset/activity_labels.txt", sep = "", header = FALSE)
colnames(activityLabels) <- c("activityId","activityDescription")

features <- read.table("C:/Users/Steve/Desktop/Data Science/Data Science - John Hopkins University Coursera/Getting and Cleaning Data/Week 4/UCI HAR Dataset/features.txt", sep = "", header = FALSE)



#Get only the columns pertaining to mean and standard deviations
meanColumns <- as.data.frame(grep( "mean", features$V2))
stdColumns <- as.data.frame(grep( "std",  features$V2))

#Create common column names for both dataframes 
colnames(meanColumns)<- "columnIndex"
colnames(stdColumns)<- "columnIndex"


#Combine both mean and std column indexes into one dataframe
selectColumns <- rbind(meanColumns, stdColumns)

#Sort by column index ascending order
selectColumns <- arrange(selectColumns,  columnIndex)

featuresSelected <- features$V2[selectColumns$columnIndex]
#features_selected
#select_columns

#-----------------Clean-up feature column names-------------------------------------------------------------


#Replace abreviations for accelerometer and gyroscope with actual word
featuresSelected <- sub("Acc", "Accelerometer", featuresSelected)
featuresSelected <- sub("Gyro", "Gyroscope", featuresSelected)

#Remove dashes and elipses from name
featuresSelected <- gsub("-","",featuresSelected)
featuresSelected <- gsub("\\()","",featuresSelected)

#Confvert 'f' to frequency and 't' to time at beginning of column name
featuresSelected <- sub("f","frequency",featuresSelected)
featuresSelected <- sub("t","time",featuresSelected)



#---------------Get Test Group data: Data, Student Info, and Activities--------------------------------------

#Get student data
TestStudentGroup <- read.table("C:/Users/Steve/Desktop/Data Science/Data Science - John Hopkins University Coursera/Getting and Cleaning Data/Week 4/UCI HAR Dataset/test/subject_test.txt", sep = "", header = FALSE)
colnames(TestStudentGroup) <- c("studentId")


#Get student activities
ActivitiesByTestStudentGroup <- read.table("C:/Users/Steve/Desktop/Data Science/Data Science - John Hopkins University Coursera/Getting and Cleaning Data/Week 4/UCI HAR Dataset/test/y_test.txt", sep = "", header = FALSE)
colnames(ActivitiesByTestStudentGroup) <- c("activityId")

#Get student data
PreTestStudentGroupMeasureData <- read.table("C:/Users/Steve/Desktop/Data Science/Data Science - John Hopkins University Coursera/Getting and Cleaning Data/Week 4/UCI HAR Dataset/test/X_test.txt", sep = "", header = FALSE)

#Get mean and std columns from data table
i <- 1
for (i in selectColumns[i]){
  TestStudentGroupMeasureData <- PreTestStudentGroupMeasureData[,i]
 i <- i + 1
}


#Update Column names
colnames(TestStudentGroupMeasureData) <- featuresSelected


#Merge student activities with activity labels matching on activityId
ActivitiesByTestStudentGroup <- merge(ActivitiesByTestStudentGroup, activityLabels)



#Join activities with students on index
ActivitiesByTestStudentId <- merge(TestStudentGroup, ActivitiesByTestStudentGroup,  by.x = 0, by.y = 0, row.names=FALSE)
#Drop Row Name column
drops <- c("Row.names")
ActivitiesByTestStudentId <- ActivitiesByTestStudentId[ , !(names(ActivitiesByTestStudentId) %in% drops)]

#Join on index the activity and student data with measure data
MeasureTestGroupData <- merge(ActivitiesByTestStudentId, TestStudentGroupMeasureData,  by.x = 0, by.y = 0, row.names=FALSE)

#Drop Row Name column
drops <- c("Row.names")
MeasureTestGroupData <- MeasureTestGroupData[ , !(names(MeasureTestGroupData) %in% drops)]


MeasureTestGroupData <- mutate(MeasureTestGroupData, groupType = "test")

#---------------Get Training Group data: Data, Student Info, and Activities--------------------------------------

#Get student data
TrainStudentGroup <- read.table("C:/Users/Steve/Desktop/Data Science/Data Science - John Hopkins University Coursera/Getting and Cleaning Data/Week 4/UCI HAR Dataset/train/subject_train.txt", sep = "", header = FALSE)
colnames(TrainStudentGroup) <- c("studentId")

#Get student activities
ActivitiesByTrainStudentGroup <- read.table("C:/Users/Steve/Desktop/Data Science/Data Science - John Hopkins University Coursera/Getting and Cleaning Data/Week 4/UCI HAR Dataset/train/y_train.txt", sep = "", header = FALSE)
colnames(ActivitiesByTrainStudentGroup) <- c("activityId")

#Get student data
PreTrainStudentGroupMeasureData <- read.table("C:/Users/Steve/Desktop/Data Science/Data Science - John Hopkins University Coursera/Getting and Cleaning Data/Week 4/UCI HAR Dataset/train/X_train.txt", sep = "", header = FALSE)

#Get mean and std columns from data table
i <- 1
for (i in selectColumns[i]){
  TrainStudentGroupMeasureData <- PreTrainStudentGroupMeasureData[,i]
  i <- i + 1
}

#Update Column names
colnames(TrainStudentGroupMeasureData) <- featuresSelected


#Merge student activities with activity labels matching on activityId
ActivitiesByTrainStudentGroup <- merge(ActivitiesByTrainStudentGroup, activityLabels)

#Join activities with students on index
ActivitiesByTrainStudentId <- merge(TrainStudentGroup, ActivitiesByTrainStudentGroup,  by.x = 0, by.y = 0, row.names=FALSE)

#Drop Row Name column
drops <- c("Row.names")
ActivitiesByTrainStudentId <- ActivitiesByTrainStudentId[ , !(names(ActivitiesByTrainStudentId) %in% drops)]

#Join on index the activity and student data with measure data
MeasureTrainGroupData <- merge(ActivitiesByTrainStudentId, TrainStudentGroupMeasureData,  by.x = 0, by.y = 0, row.names=FALSE)

#Drop Row Name column
drops <- c("Row.names")
MeasureTrainGroupData <- MeasureTrainGroupData[ , !(names(MeasureTrainGroupData) %in% drops)]


MeasureTrainGroupData <- mutate(MeasureTrainGroupData, groupType = "training")


#------Merge test training sets together and calculate averages by activity and student-------------------------------
MeasureGroupDataCombined <- rbind(MeasureTestGroupData, MeasureTrainGroupData)

#names(MeasureGroupDataCombined)

#Calculate averages by activity and student
activityStudentAverages <- MeasureGroupDataCombined%>%
  group_by(activityDescription, studentId)%>%
  summarize( mean(timeBodyAccelerometermeanY), mean(timeBodyAccelerometermeanX) #5
            , mean(timeBodyAccelerometerstdX), mean(timeBodyAccelerometerstdY) #7
            , mean(timeBodyAccelerometerstdZ), mean(timeGravityAccelerometermeanX) #9
            , mean(timeGravityAccelerometermeanY), mean(timeGravityAccelerometermeanZ) #11
            , mean(timeGravityAccelerometerstdX), mean(timeGravityAccelerometerstdY) #13
            , mean(timeGravityAccelerometerstdZ), mean(timeBodyAccelerometerJerkmeanX) #15
            , mean(timeBodyAccelerometerJerkmeanY), mean(timeBodyAccelerometerJerkmeanZ) #17
            , mean(timeBodyAccelerometerJerkstdX), mean(timeBodyAccelerometerJerkstdY) #19
            , mean(timeBodyAccelerometerJerkstdZ), mean(timeBodyGyroscopemeanX) #21
            , mean(timeBodyGyroscopemeanY), mean(timeBodyGyroscopemeanZ) #23
            , mean(timeBodyGyroscopestdX), mean(timeBodyGyroscopestdY)  #25
            , mean(timeBodyGyroscopestdZ), mean(timeBodyGyroscopeJerkmeanX) #27
            , mean(timeBodyGyroscopeJerkmeanY), mean(timeBodyGyroscopeJerkmeanZ)  #29
            , mean(timeBodyGyroscopeJerkstdX), mean(timeBodyGyroscopeJerkstdY) #31
            , mean(timeBodyGyroscopeJerkstdZ), mean(timeBodyAccelerometerMagmean) #33
            , mean(timeBodyAccelerometerMagstd), mean(timeGravityAccelerometerMagmean) #35
            , mean(timeGravityAccelerometerMagstd), mean(timeGravityAccelerometerMagmean) #37
            , mean(timeBodyAccelerometerJerkMagstd), mean(timeBodyGyroscopeMagmean) #39
            , mean(timeBodyGyroscopeMagstd)	, mean(timeBodyGyroscopeJerkMagmean)	#41
            , mean(timeBodyGyroscopeJerkMagstd)	, mean(frequencyBodyAccelerometermeanX)	#43
            , mean(frequencyBodyAccelerometermeanY)	, mean(frequencyBodyAccelerometermeanZ)	#45
            , mean(frequencyBodyAccelerometerstimedX)	, mean(frequencyBodyAccelerometerstimedY)	#47
            , mean(frequencyBodyAccelerometerstimedZ)	, mean(frequencyBodyAccelerometermeanFreqX)	#49
            , mean(frequencyBodyAccelerometermeanFreqY)	, mean(frequencyBodyAccelerometermeanFreqZ)	#51
            , mean(frequencyBodyAccelerometerJerkmeanX)	, mean(frequencyBodyAccelerometerJerkmeanY)	#53
            , mean(frequencyBodyAccelerometerJerkmeanZ)	, mean(frequencyBodyAccelerometerJerkstimedX)	#55
            , mean(frequencyBodyAccelerometerJerkstimedY)	, mean(frequencyBodyAccelerometerJerkstimedZ)	#57
            , mean(frequencyBodyAccelerometerJerkmeanFreqX)	, mean(frequencyBodyAccelerometerJerkmeanFreqY)	#59
            , mean(frequencyBodyAccelerometerJerkmeanFreqZ)	, mean(frequencyBodyGyroscopemeanX)	#61
            , mean(frequencyBodyGyroscopemeanY)	, mean(frequencyBodyGyroscopemeanZ)	#63
            , mean(frequencyBodyGyroscopestimedX)	, mean(frequencyBodyGyroscopestimedY)	#65
            , mean(frequencyBodyGyroscopestimedZ)	, mean(frequencyBodyGyroscopemeanFreqX)	#67
            , mean(frequencyBodyGyroscopemeanFreqY)	, mean(frequencyBodyGyroscopemeanFreqZ)	#69
            , mean(frequencyBodyAccelerometerMagmean)	, mean(frequencyBodyAccelerometerMagstimed)	#71
            , mean(frequencyBodyAccelerometerMagmeanFreq)	, mean(frequencyBodyBodyAccelerometerJerkMagmean)	#73
            , mean(frequencyBodyBodyAccelerometerJerkMagstimed)	, mean(frequencyBodyBodyAccelerometerJerkMagmeanFreq)	#75
            , mean(frequencyBodyBodyGyroscopeMagmean)	, mean(frequencyBodyBodyGyroscopeMagstimed)	#77
            , mean(frequencyBodyBodyGyroscopeMagmeanFreq)	, mean(frequencyBodyBodyGyroscopeJerkMagmean)	#79
            , mean(frequencyBodyBodyGyroscopeJerkMagstimed)	, mean(frequencyBodyBodyGyroscopeJerkMagmeanFreq)	#81
            )%>%
  arrange(activityDescription, studentId)

colnames(activityStudentAverages) <- c(names(MeasureGroupDataCombined[3]), names(MeasureGroupDataCombined[1]) , paste("average",names(MeasureGroupDataCombined[5:81]),sep = "")) #82
#colnames(activityStudentAverages) <- c(names(MeasureGroupDataCombined[3]), names(MeasureGroupDataCombined[1]) , names(MeasureGroupDataCombined[5:81])) #82


View(activityStudentAverages)






