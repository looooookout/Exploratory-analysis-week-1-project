dataurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (! file.exists("exdata_data_household_power_consumption.zip")){
    download.file(dataurl, destfile = "powerdataset.zip", mode ='wb')
}
if (!file.exists("./household_power_consumption.txt")){
    unzip("powerdataset.zip")
}


powerdata <- read.table("household_power_consumption.txt", 
                        na.strings = "?", sep = ";", 
                        skip = (grep("1/2/2007|2/2/2007", 
                                     readLines("household_power_consumption.txt"))-1), 
                        nrows = 2880)
names(powerdata) <- read.table("household_power_consumption.txt",nrows = 1, sep = ";",colClasses = "character")

png("plot1.png", width = 480, height = 480)
    hist(powerdata$Global_active_power,main = "Global Active Power", 
         xlab = "Global Active Power(kilowatts)", col = "red")
dev.off()

#png("plot1.png", width = 480, height = 480)
par(mar=c(4,4,2,2))
hist(powerdata$Global_active_power, main="Global Active Power",col='red',ylab= "Frequency", xlab="Global Active Power(kilowatts)")
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()