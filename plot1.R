#John Hopkins Univeristy, via Coursera
#Course: Exploring Data Analysis
#Project: Week 1 Graphing
#Student: Steve Orosz
#Date: 4/1/2018

#Purpose: Read in filtered file for 2/1/2007 and 2/2/2007 dates and create plot 1

#-----Read File----------------
#getwd()
setwd("C:/Users/Steve/Desktop/Data Science/Data Science - John Hopkins University Coursera/Exploratory Data Analysis")
#list.files()

selectDates <- read.csv("selectDates.txt", sep = ",", stringsAsFactors = FALSE)


#----Plot 1 Code ---------------
par(mfrow = c(1,1), mar = c(5,4,2,1))

plot1Data <- as.numeric(selectDates$Global_active_power)

hist(plot1Data, xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power", ylim = c(0,1200))

dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()