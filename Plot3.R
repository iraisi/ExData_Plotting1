## Plot for Sub Metering

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
png("plot3.png", height=480, width=480)

# Plotting Sub_metering
plot(powerSub$DateTime, powerSub$Sub_metering_1,
     xlab="", 
     ylab="Energy sub metering", 
     main="",
     pch=NA,
)
lines(powerSub$DateTime, powerSub$Sub_metering_1, col="black")
lines(powerSub$DateTime, powerSub$Sub_metering_2, col="red")
lines(powerSub$DateTime, powerSub$Sub_metering_3, col="blue")
legend(x="topright", legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
      col=c("black", "red", "blue"),
      lty=c(1,1,1), 
      bty="i")
# Closing graphic device
dev.off()
##################################################