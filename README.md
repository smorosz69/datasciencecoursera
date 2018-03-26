
#The following scripts were used to load the the UCI study on "Human Acitivy Recognition Using Smartphones Data Set"

#See following link for more information about observations and variables in the study.

#http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


#----------------------Download and unzip files-----------------------------------------------------------

#Download project files
UrlLink <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#download(UrlLink, dest="dataset.zip", mode="wb") 
#unzip ("dataset.zip", exdir = "./")

#temp <- tempfile()
#download.file(UrlLink, destfile = "dataset.zip",temp)
download.file(UrlLink,"week_four_project")

#-------------------Read in activity and feature data files-----------------------------------------

#Get files for activities and features
activityLabels <- read.table("C:/Users/Steve/Desktop/Data Science/Data Science - John Hopkins University Coursera/Getting and Cleaning Data/Week 4/UCI HAR Dataset/activity_labels.txt", sep = "", header = FALSE)
colnames(activityLabels) <- c("activityId","activityDescription")

features <- read.table("C:/Users/Steve/Desktop/Data Science/Data Science - John Hopkins University Coursera/Getting and Cleaning Data/Week 4/UCI HAR Dataset/features.txt", sep = "", header = FALSE)

#---------------Get Test Group data: Data, Student Info, and Activities--------------------------------------

#Get student data
TestStudentGroup <- read.table("C:/Users/Steve/Desktop/Data Science/Data Science - John Hopkins University Coursera/Getting and Cleaning Data/Week 4/UCI HAR Dataset/test/subject_test.txt", sep = "", header = FALSE)
colnames(TestStudentGroup) <- c("studentId")

#Get student activities
ActivitiesByTestStudentGroup <- read.table("C:/Users/Steve/Desktop/Data Science/Data Science - John Hopkins University Coursera/Getting and Cleaning Data/Week 4/UCI HAR Dataset/test/y_test.txt", sep = "", header = FALSE)
colnames(ActivitiesByTestStudentGroup) <- c("activityId")

#Get student data
PreTestStudentGroupMeasureData <- read.table("C:/Users/Steve/Desktop/Data Science/Data Science - John Hopkins University Coursera/Getting and Cleaning Data/Week 4/UCI HAR Dataset/test/X_test.txt", sep = "", header = FALSE)

#---------------Get Training Group data: Data, Student Info, and Activities--------------------------------------

#Get student data
TrainStudentGroup <- read.table("C:/Users/Steve/Desktop/Data Science/Data Science - John Hopkins University Coursera/Getting and Cleaning Data/Week 4/UCI HAR Dataset/train/subject_train.txt", sep = "", header = FALSE)
colnames(TrainStudentGroup) <- c("studentId")

#Get student activities
ActivitiesByTrainStudentGroup <- read.table("C:/Users/Steve/Desktop/Data Science/Data Science - John Hopkins University Coursera/Getting and Cleaning Data/Week 4/UCI HAR Dataset/train/y_train.txt", sep = "", header = FALSE)
colnames(ActivitiesByTrainStudentGroup) <- c("activityId")

#Get student data
PreTrainStudentGroupMeasureData <- read.table("C:/Users/Steve/Desktop/Data Science/Data Science - John Hopkins University Coursera/Getting and Cleaning Data/Week 4/UCI HAR Dataset/train/X_train.txt", sep = "", header = FALSE)

