## File containing data
file <- ".\\exdata_data_household_power_consumption\\household_power_consumption.txt"

## Read data from file into data.frame power
power <- read.table(file, sep=";", header=TRUE, colClasses="character")

## Subset power into partialPower for days Feb 1, 2007 and Feb 2, 2007
partialPower <- power[power$Date == "1/2/2007" | power$Date == "2/2/2007",]

## Create date, time format string
format <- "%d/%m/%Y %X"

## Combine Date and Time columns in partialPower into a POSIXct column 
## DateTime
partialPower$DateTime <- with(partialPower, strptime(paste(Date, Time), format))

## Open up png graphics device
png("plot2.png")
## Draw plot
with(partialPower, plot(DateTime, Global_active_power, type="l", 
     xlab="", ylab="Global Active Power (kilowatts)"))
## Close graphics device
dev.off()
