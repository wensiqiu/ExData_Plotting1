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
png(file="plot4.png", width=480, height=480, units="px")
par(mfrow=c(2,2))
with(data, {
        plot(data[, c(10, 3)], type="l", xlab="", ylab="Global Active Power (kilowatts)")
        plot(data[, c(10, 5)], type="l", xlab="datetime", ylab="Vottage")
        op <- par(cex=.64)
        plot(data[, c(10,7)], type="l", col="black", ylim=range(data[,7:9]), ylab="", xlab="")
        par(new = TRUE)
        plot(data[, c(10,8)], type="l", col="red", ylim=range(data[,7:9]), ylab="", xlab="")
        par(new = TRUE)
        plot(data[, c(10,9)], type="l", col="blue", ylim=range(data[,7:9]), ylab="", xlab="")
        title(ylab="Energy sub metering", xlab="")
        legend("topright", legend=colnames(data)[7:9], lty=1, col=c("black", "red", "blue"), 
               text.font=2)
        par(op)
        plot(data[, c(10, 4)], type="l", xlab="datetime", ylab="Global_reactive_power")
})

dev.off()