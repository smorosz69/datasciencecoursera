#John Hopkins Univeristy, via Coursera
#Course: Exploring Data Analysis
#Project: Week 1 Graphing
#Student: Steve Orosz
#Date: 4/1/2018

#Purpose: Read in filtered file for 2/1/2007 and 2/2/2007 dates and create plot 4

#-----Read File----------------
#getwd()
setwd("C:/Users/Steve/Desktop/Data Science/Data Science - John Hopkins University Coursera/Exploratory Data Analysis")
#list.files()

selectDates <- read.csv("selectDates.txt", sep = ",", stringsAsFactors = FALSE)

#str(selectDates)

#----Plot 4 Code ---------------
par(mfrow = c(2,2), mar = c(5,4,2,1))

#Almost the same code as plot 2
ActivePower <- as.numeric(selectDates$Global_active_power)
DayLabels <- names(table(wday(selectDates$DateStrip, label=TRUE)))

plot (ActivePower, type = "l", ylab = "Global Active Power", xaxt = 'n', xlab = "")
axis(side = 1 , at = c(25,1500,2900), labels = DayLabels[5:7])

#New Plot. Plot 2
Voltage <- as.numeric(selectDates$Voltage)

plot (Voltage, type = "l", ylab = "Voltage", xaxt = 'n', xlab = "datetime")
axis(side = 1 , at = c(25,1500,2900), labels = DayLabels[5:7])


#Plot 3 code
Sub_metering_1 <- as.numeric(selectDates$Sub_metering_1)
Sub_metering_2 <- as.numeric(selectDates$Sub_metering_2)
Sub_metering_3 <- as.numeric(selectDates$Sub_metering_3)

plot(Sub_metering_1, type = "l", ylab = "Enery sub metering", xaxt = 'n', col = "black", xlab = "")
lines(Sub_metering_2, type = "l", xaxt = 'n', col = "red")
lines(Sub_metering_3, type = "l", xaxt = 'n', col = "blue")
axis(side = 1 , at = c(25,1500,2900), labels = DayLabels[5:7])
#legend("topright", lty=c(1,1) , col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") , lty = 1, cex = 0.5, lwd=1, bty = "n")


#New Plot. Plot 4
GlobalReactivePower <- as.numeric(selectDates$Global_reactive_power)

plot (GlobalReactivePower, type = "l", ylab = "Global_reactive_power", xaxt = 'n', xlab = "datetime", log="y")
axis(side = 1 , at = c(25,1500,2900), labels = DayLabels[5:7])

dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()

