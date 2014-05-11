# This function creates the plot nr 1 for project 1
# and saves it as a PNG file in the current work directory.
# The input file "household_power_consumption.txt" is
# assumed to exist in the working directory as well.
plot1 <- function() {
  png("plot1.png")
  consData <- readConsData()
  hist(consData$Global_active_power, xlab="Global Active Power (kilowatts)", 
       col=2, main="Global Active Power")
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