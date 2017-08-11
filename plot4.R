#Download file from internet and unzip
setwd("C:\\Users\\Sven\\Desktop\\ExData_Plotting1\\") #  set working directory
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("RawData.zip")){download.file(url = URL, destfile = "RawData.zip")}; unzip("RawData.zip"); rm(URL) # if file already exists otherwise download and unzip


library(data.table)
library(fasttime)
Data <- fread("C:\\Users\\Sven\\Desktop\\ExData_Plotting1\\household_power_consumption.txt", na.strings="?") # read data
Data[, Date := as.Date(Date, format ="%d/%m/%Y")] # convert date to date class
Data[, DateTime :=  fastPOSIXct(paste(Date, Time), tz = "GMT")][,c("Date", "Time") := NULL] # generate DateTime column
Data <- Data[DateTime >= "2007-02-01 00:00:00" & DateTime <= "2007-02-02 23:59:99",]

#Plotting
png(filename = "Plot4.png", width = 480, height = 480)
par(mfrow = c(2,2),mar=c(4,4,2,1), oma=c(0,0,2,0))
#Plot 1
plot(Data$DateTime, Data$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")
# Plot 2
plot(Data$DateTime, Data$Voltage, type = "l", ylab = "Voltage", xlab = "datetime") 
# Plot 3
plot(Data$DateTime, Data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "") 
lines(Data$DateTime, Data$Sub_metering_2, col = "red")
lines(Data$DateTime, Data$Sub_metering_3, col = "blue")
legend("topright",legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, cex=0.5)
# Plot4
plot(Data$DateTime, Data$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime") 
dev.off()


