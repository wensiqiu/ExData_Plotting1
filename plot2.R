# Read the data from files
fileDir <- paste(getwd(), "household_power_consumption.txt", sep="/")
data <- read.table(file=fileDir, sep=";", skip=66637,nrows=2880, 
                   col.names = colnames(read.table(file=fileDir, nrow=1, header=TRUE, sep=";")))

# Transform the data 
data[, 3:9] <- apply(data[, 3:9], 2, function(x) as.numeric(x))
dates <- data$Date
dates <- gsub("1/2/2007", "01/02/2007", dates)
dates <- gsub("2/2/2007", "02/02/2007", dates)
times <- data$Time
x <- paste(dates, times)
data$DateTime <- strptime(x, format="%d/%m/%Y %H:%M:%S")

# Construct a plot
png(file="plot2.png", width=480, height=480, units="px")
plot(data[, c(10, 3)], type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
