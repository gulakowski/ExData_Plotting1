plot2 <- function(){
##Check for file
    if(!file.exists("household_power_consumption.txt")){
        ## Get Data
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl,"power.zip")
        unzip("power.zip")
    } ## end if
## Read Data in
    powerdata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = 
                                c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),
                            na.strings ="?")
##Transform Date and Time
    powerdata$Date <- as.Date.character(powerdata$Date, format = "%d/%m/%Y")
    powerdata$Time <- format(strptime(powerdata$Time, format = "%H:%M:%S"),"%H:%M:%S")
## Strip Data for desired time period
    powerdata <- powerdata[powerdata$Date == "2007-02-01" | powerdata$Date == "2007-02-02",]
    
    a<- with(powerdata, as.POSIXct(paste(powerdata$Date, powerdata$Time)))
    powerdata = cbind(powerdata, "Date Time" = a)
##Plot Histogram
    hist(powerdata$Global_active_power, xlab = "Global Active Power (kilowatts)",
         main = "Global Active Power", col = "red1")
## save plot    
    dev.copy(png, file = "plot1.png")
    dev.off()
} ## end function