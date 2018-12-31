#Download data file if it did not exits
dataurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (! file.exists("powerdataset.zip")){
    download.file(dataurl, destfile = "powerdataset.zip", mode ='wb')
}
if (!file.exists("./household_power_consumption.txt")){
    unzip("powerdataset.zip")
}

#Read data to R and assign the names for each column
powerdata <- read.table("household_power_consumption.txt", 
                        na.strings = "?", sep = ";", 
                        skip = (grep("1/2/2007|2/2/2007", 
                                     readLines("household_power_consumption.txt"))-1), 
                        nrows = 2880)
names(powerdata) <- read.table("household_power_consumption.txt",nrows = 1, sep = ";",colClasses = "character")

#Convert the date and time classes
powerdata$Date <- as.Date (powerdata$Date, format = "%d/%m/%Y")
powerdata$contimes <- as.POSIXct(paste(powerdata$Date,powerdata$Time))

#Plotting
plot (powerdata$contimes,powerdata$Sub_metering_1, type = "l", xlab = "Date",ylab = "Energy sub metering")
lines(powerdata$contimes,powerdata$Sub_metering_2, type = "l",col = "red")
lines(powerdata$contimes,powerdata$Sub_metering_3,type = "l", col="blue")
legend ("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = 1, col = c("black","red","blue"))

#Out put the png file
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()