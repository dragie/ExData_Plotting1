## path to file holding data file
file <- ".\\exdata_data_household_power_consumption\\household_power_consumption.txt"

## read the file
power <- read.table(file, sep=";", header=TRUE, colClasses="character")

## Subset power into partialPower for days Feb 1, 2007 and Feb 2, 2007
partialPower <- power[power$Date == "1/2/2007" | power$Date == "2/2/2007",]

## Create date, time format string
format <- "%d/%m/%Y %X"

## Combine Date and Time columns in partialPower into a POSIXct column 
## datetime
partialPower$datetime <- with(partialPower, strptime(paste(Date, Time), format))

## Open up graphics device to png file, Plot4.png
png("plot4.png")

## Set up 4 graphs
par(mfcol = c(2,2))

#### GRAPH #1
with(partialPower, plot(datetime, Global_active_power, type="l", 
     xlab="", ylab="Global Active Power (kilowatts)"))


#### GRAPH #2
## Convert needed columns to numbers
partialPower$Sub_metering_1 <- as.numeric(partialPower$Sub_metering_1)
partialPower$Sub_metering_2 <- as.numeric(partialPower$Sub_metering_2)
partialPower$Sub_metering_3 <- as.numeric(partialPower$Sub_metering_3)

## Find maximums
max1 <- max(partialPower$Sub_metering_1)
max2 <- max(partialPower$Sub_metering_2)
max3 <- max(partialPower$Sub_metering_3)


## Draw empty graph for maximum Sub_metering, so size of plot will hold 
## all the data
if(max1 >= max2 && max1 >= max3) {
     with(partialPower, plot(datetime, Sub_metering_1, type="n", 
          xlab="", ylab="Energy sub metering"))
} else if(max2 >= max3) {
     with(partialPower, plot(datetime, Sub_metering_2,type="n",
          xlab="", ylab="Energy sub metering"))
} else {
     with(partialPower, plot(datetime, Sub_metering_3, type="n", 
          xlab="", ylab="Energy sub metering"))
}
with(partialPower, {
     lines(datetime, Sub_metering_1, col="black")
     lines(datetime, Sub_metering_2, col="red")
     lines(datetime, Sub_metering_3, col="blue")
})

legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1,1), col=c("black", "red", "blue"), bty="n")


#### GRAPH #3
partialPower$Voltage <- as.numeric(partialPower$Voltage)
with(partialPower, plot(datetime, Voltage, type="l"))

#### GRAPH #4
partialPower$Global_reactive_power <- as.numeric(partialPower$Global_reactive_power)
with(partialPower, plot(datetime, Global_reactive_power, type="l"))

dev.off()
