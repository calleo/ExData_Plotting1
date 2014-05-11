# This function creates the plot nr 3 for project 1
# and saves it as a PNG file in the current work directory.
# The input file "household_power_consumption.txt" is
# assumed to exist in the working directory as well.
plot3 <- function() {
  png("plot3.png")
  consData <- readConsData()
  plot(consData$Date, consData$Sub_metering_1, type="l", ylab = "Energy sub metering",
       xlab = "", col = 1)
  points(consData$Date, consData$Sub_metering_2,type="l", col=2)
  points(consData$Date, consData$Sub_metering_3,type="l", col=4)
  legend("topright",lwd = 1, col=c("black","blue","red"),legend=c("Sub_metering_1",
                                          "Sub_metering_2", "Sub_metering_3"))
  dev.off()
}

readConsData <- function() {
  
  # Load data for the relevant dates
  start <- 66637
  end <- 69517
  lines <- end - start
  # Get column headers by reading the first line
  cols <- readLines("household_power_consumption.txt", n = 1)
  cols <- strsplit(cols, ";")
  consData <- read.table("household_power_consumption.txt", skip = start, sep = ";", 
                         nrows = lines, na.strings = "?", col.names = cols[[1]])
  
  # Convert dates/time from external format
  consData$Date <- paste(consData$Date, consData$Time)
  consData <- consData[,!(names(consData) %in% c("Time"))]
  consData$Date <- strptime(consData$Date,"%d/%m/%Y %H:%M:%S")
  
  return(consData)
}