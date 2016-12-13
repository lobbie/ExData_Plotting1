# Johhs Hopskins University Course 4 Exploratory Data Analysis
# Course Project 1 - plot1.R
# Prepared by William Thong
###############################################################

# Are there sufficient memory for loading all the records into R?
# Rough estimate using formular -> # rows * # columns * 8 bytes / 2^20
# Which is 9 *  2,075,259 * 8 / 2^20 =  142.50 Mb
# There are sufficent memory but I went ahead to read in only records 
# from the selected dates 2007-02-01 and 2007-02-02.

# set working directory - need to set working directory
setwd("C:/MyCourse/Data Science_JohnsHopskinsUniversity/04 Exploratory Data Analysis/Week01/CourseProject1")
getwd()

# load libraries
library(dplyr)
library(sqldf)

# import subset of data using sqldf package
dfPower <- read.csv.sql("./household_power_consumption.txt", 
                      sql='select * from file where Date="1/2/2007" or Date="2/2/2007"',
                        header=TRUE, sep = ";", eol = "\n")
closeAllConnections()

# convert Date & Time variables into R Date/Time classes
dfPower$Time <- paste(dfPower$Date, dfPower$Time, sep=":") 
dfPower <- dfPower %>%
  mutate(datetime=as.POSIXct(strptime(dfPower$Time, format="%d/%m/%Y:%H:%M:%S"))) %>%
  select(10,3:9)
str(dfPower)


# Plot 1 - plot graph and output png
dev.off()
hist(dfPower$Global_active_power, main="Global Active Power", 
     col="red", xlab="Global Active Power (kilowatts)")

dev.copy(png,"plot1.png", width=480, height=480)
dev.off()



