#Download file from internet and unzip
setwd("C:\\Users\\Sven\\Desktop\\ExData_Plotting1\\") #  set working directory
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("RawData.zip")){download.file(url = URL, destfile = "RawData.zip")}; unzip("RawData.zip"); rm(URL) # if file already exists otherwise download and unzip


library(data.table)
library(fasttime)
Data <- fread("C:\\Users\\Sven\\Desktop\\ExData_Plotting1\\household_power_consumption.txt", na.strings="?") # read data
Data[, Date := as.Date(Date, format ="%d/%m/%Y")] # convert date to date class
Data[, DateTime :=  fastPOSIXct(paste(Date, Time))][,c("Date", "Time") := NULL] # generate DateTime column
Data <- Data[DateTime >= "2007-02-01 00:00:00" & DateTime <= "2007-02-02 23:59:99",]
png(filename = "Plot1.png", width = 480, height = 480)
hist(Data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()
