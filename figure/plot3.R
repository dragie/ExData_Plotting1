## path to file holding data file
file <- ".\\exdata_data_household_power_consumption\\household_power_consumption.txt"

## read the file
power <- read.table(file, sep=";", header=TRUE, colClasses="character")

## Subset power into partialPower for days Feb 1, 2007 and Feb 2, 2007
partialPower <- power[power$Date == "1/2/2007" | power$Date == "2/2/2007",]

## Create date, time format string
format <- "%d/%m/%Y %X"

## Combine Date and Time columns in partialPower into a POSIXct column 
## DateTime
partialPower$DateTime <- with(partialPower, strptime(paste(Date, Time), format))

## Convert Sub_metering columns to numbers
partialPower$Sub_metering_1 <- as.numeric(partialPower$Sub_metering_1)
partialPower$Sub_metering_2 <- as.numeric(partialPower$Sub_metering_2)
partialPower$Sub_metering_3 <- as.numeric(partialPower$Sub_metering_3)

## Find maximums
max1 <- max(partialPower$Sub_metering_1)
max2 <- max(partialPower$Sub_metering_2)
max3 <- max(partialPower$Sub_metering_3)

png("plot3.png")
## Draw empty graph for maximum Sub_metering, so size of plot will hold 
## all the data
if(max1 >= max2 && max1 >= max3) {
     with(partialPower, plot(DateTime, Sub_metering_1, type="n", 
          xlab="", ylab="Energy sub metering"))
} else if(max2 >= max3) {
     with(partialPower, plot(DateTime, Sub_metering_2,type="n",
          xlab="", ylab="Energy sub metering"))
} else {
     with(partialPower, plot(DateTime, Sub_metering_3, type="n", 
          xlab="", ylab="Energy sub metering"))
}
with(partialPower, {
     lines(DateTime, Sub_metering_1, col="black")
     lines(DateTime, Sub_metering_2, col="red")
     lines(DateTime, Sub_metering_3, col="blue")
})

legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1,1), col=c("black", "red", "blue"))
dev.off()
