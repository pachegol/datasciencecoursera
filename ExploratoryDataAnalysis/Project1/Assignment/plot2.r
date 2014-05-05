### Code to create the first plot (Histogram of Global Active Power)

### load data.


powComp <- read.table("~./data/household_power_consumption.txt", sep =";", header=TRUE, stringsAsFactors=FALSE)

## Format date as.Date

powComp$Date2 <- as.Date(powComp$Date, format="%d/%m/%Y")

str(powComp)

## Create a Column called "DateTime" using POSIXct format
powComp$DateTime <- as.POSIXct(paste(powComp$Date, powComp$Time), format="%d/%m/%Y %H:%M:%S")

## we don't need the Date2 column anymore
powComp$Date2 <- NULL


## Subset the data
powCompSample <- subset(powComp, DateTime >= as.POSIXct("2007-02-01") & DateTime < as.POSIXct("2007-02-03"))

## Remove the big dataset since it is not needed anymore

remove(powComp)

## Create histogram using Base R grahpics and save it to a file
png()
png(filename="plot2.png") # default is 480x480

plot(powCompSample$DateTime, as.numeric(powCompSample$Global_active_power), 
     type="l",
     ylab = "Global Active Power (kilowatts)"
     )

dev.off()


