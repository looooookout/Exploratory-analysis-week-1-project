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

#Plot the graph and output for a png file
plot (powerdata$contimes,powerdata$Global_active_power, type = "l", xlab = "Date",ylab = "Global Active Power(Kilowatts)")
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()