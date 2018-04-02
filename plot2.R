#John Hopkins Univeristy, via Coursera
#Course: Exploring Data Analysis
#Project: Week 1 Graphing
#Student: Steve Orosz
#Date: 4/1/2018

#Purpose: Read in filtered file for 2/1/2007 and 2/2/2007 dates and create plot 2

#-----Read File----------------
#getwd()
setwd("C:/Users/Steve/Desktop/Data Science/Data Science - John Hopkins University Coursera/Exploratory Data Analysis")
#list.files()

selectDates <- read.csv("selectDates.txt", sep = ",", stringsAsFactors = FALSE)

#----Plot 2 Code ---------------
par(mfrow = c(1,1), mar = c(5,4,2,1))

ActivePower <- as.numeric(selectDates$Global_active_power)
DayLabels <- names(table(wday(selectDates$DateStrip, label=TRUE)))

plot (ActivePower, type = "l", ylab = "Global Active Power (kilowatts)", xaxt = 'n', xlab = "")
axis(side = 1 , at = c(25,1500,2900), labels = DayLabels[5:7])

dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()