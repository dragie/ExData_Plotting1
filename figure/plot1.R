## Location of data file
file <- ".\\exdata_data_household_power_consumption\\household_power_consumption.txt"

## Read the file into data.frame power
power <- read.table(file, sep=";", header=TRUE, colClasses="character")

## Get the rows of corresponding to 1/2/2007 and 2/2/2007
## Corresponding to Feb 1, 2007 and Feb 2, 2007 in the format d/m/year.
partialPower <- power[power$Date == "1/2/2007" | power$Date == "2/2/2007",]

## Get the column Global_active_power from partialPower, and put it into
## variable GAP
GAP <- partialPower$Global_active_power

## The data in GAP is all in numeric form, convert character data to numbers
GAP <- as.numeric(GAP)

## Create a png graphics device, default size is 480px x 480px
png("plot1.png")
## Draw histogram on png device
hist(GAP, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
## Close the device, to finish the process
dev.off()
