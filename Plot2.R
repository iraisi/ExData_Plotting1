## Plot for the Global Active Power.

# Downloading data, unzipping and loading data into R.
datasetURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" 
temp <- tempfile()
download.file(url= datasetURL, method= "curl", temp)
powerData <- read.table(unz(temp, "household_power_consumption.txt"), 
                        sep=";", 
                        header=TRUE, 
                        na.strings="?", 
                        colClasses= c("character", "character", "numeric", 
                                      "numeric", "numeric", "numeric", "numeric", 
                                      "numeric", "numeric"))
unlink(temp)

# Subsetting the data for the required dates.
powerSub <- subset(powerData, powerData$Date=="1/2/2007" | powerData$Date=="2/2/2007")
# or, instead of subset() function. 
# powerSub<- powerData[(powerData$Date == "1/2/2007") | (powerData$Date == "2/2/2007"),]

# Making dates and time R friendly
powerSub$DateTime <- strptime(paste(powerSub$Date, powerSub$Time), "%d/%m/%Y %H:%M:%S")

# Open graphic device
png("plot2.png", height=480, width=480)

# Plotting Global_active_power
plot(powerSub$DateTime, powerSub$Global_active_power,  
     ylab="Global Active Power(kilowatts)", 
     xlab="",
     pch= NA)
lines(powerSub$DateTime, powerSub$Global_active_power)
# Closing graphic device
dev.off()

