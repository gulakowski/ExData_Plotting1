plot4 <- function(){
##Check for data    
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
## Set Plot Parameters
    par(mfrow = c(2,2))
    par(mar = c(4,4,1,1))
## Plot Data
    with(powerdata, {
        plot(powerdata$`Date Time`, powerdata$Global_active_power, type = "l", col = "black",
             xlab = "", ylab = "Global Active Power")
        plot(powerdata$`Date Time`, powerdata$Voltage, type = "l", col = "black", 
             xlab = "datetime", ylab = "Voltage")
        plot(powerdata$`Date Time`, powerdata$Sub_metering_1, col = "black", type = "l", xlab = " ", 
             ylab = "Energy sub metering")
            lines(powerdata$`Date Time`, powerdata$Sub_metering_2, col = "red1", type = "l")
            lines(powerdata$`Date Time`, powerdata$Sub_metering_3, col = "blue", type = "l")
            legend("topright", legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
               col = c("black","red1","blue"), pch = 95, cex = 0.6)
        plot(powerdata$`Date Time`, powerdata$Global_reactive_power, type = "l", col = "black",
               xlab = "datetime", ylab = "Global_reactive_power")
       })  ##end with
## save file
    dev.copy(png, file = "Plot4.png")   
    dev.off()
}## end function