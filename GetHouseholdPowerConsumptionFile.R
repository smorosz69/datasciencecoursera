#John Hopkins Univeristy, via Coursera
#Course: Exploring Data Analysis
#Project: Week 1 Graphing
#Student: Steve Orosz
#Date: 4/1/2018

#Purpose: Read in file and filter on Date field where date equal to 2/1/2007 or 2/2/2007.


#-----------------Libraries-------------------------
library(dplyr)
library(lubridate)

#--------------Working Directory--------------------
getwd()
setwd("C:/Users/Steve/Desktop/Data Science/Data Science - John Hopkins University Coursera/Exploratory Data Analysis")
list.files()

#----------------Read in file-------------------------
mydata <- read.csv("household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE)

#--------------- Select Date Range--------------------
#Select 2/1/2007 and 2/2/2007 dates
targetDates <- c("1/2/2007", "2/2/2007")
selectDates <- filter(mydata, Date %in% targetDates)

#---------------Create date time feld-----------------
selectDates <- mutate(selectDates, DateTime = paste(selectData$Date,selectData$Time))
selectDates <- mutate(selectDates, DateStrip = dmy_hms(DateTime))

#--------------------Write file Out------------------

write.csv(selectDates, file = "SelectDates.txt")