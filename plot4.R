
#init section
  #look for files
  if(!file.exists("household_power_consumption.txt")) {
    if(!file.exists("exdata_data_household_power_consumption.zip")) {
      temp <- tempfile()
      download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
      file <- unzip(temp)
      unlink(temp)
    }
    else
      file <- unzip("exdata_data_household_power_consumption.zip")
  }
  
  #load dataset
  fulltable<-read.csv2("household_power_consumption.txt")    
  
  #subset dataset to 2 days
  sub<-subset(fulltable, Date %in% c('1/2/2007','2/2/2007'))
  
  #clean and extend dataset
  sub$Global_active_power<-as.numeric(as.character(sub$Global_active_power))
  sub$Global_reactive_power <- as.numeric(as.character(sub$Global_reactive_power))
  sub$Voltage <- as.numeric(as.character(sub$Voltage))
  sub$DateTime<-strptime(paste(sub$Date,sub$Time), "%d/%m/%Y %H:%M:%S")
  sub$Sub_metering_1 <- as.numeric(as.character(sub$Sub_metering_1))
  sub$Sub_metering_2 <- as.numeric(as.character(sub$Sub_metering_2))
  sub$Sub_metering_3 <- as.numeric(as.character(sub$Sub_metering_3))
  
#end init section

#Plot 4 - Global Active Power/Voltage/Sub Meterings/Global_reactive_power VS DateTime
plot4 <- function() {
  par(mfrow=c(2,2))
  
  #PLOT 1
  plot(sub$DateTime,sub$Global_active_power, type="l", xlab="", ylab="Global Active Power")
  
  #PLOT 2
  plot(sub$DateTime,sub$Voltage, type="l", xlab="datetime", ylab="Voltage")
  
  #PLOT 3
  plot(sub$DateTime,sub$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  lines(sub$DateTime,sub$Sub_metering_2,col="red")
  lines(sub$DateTime,sub$Sub_metering_3,col="blue")
  legend("topright", col=c(1,2,4), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5) 
  
  #PLOT 4
  plot(sub$DateTime,sub$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
  
  #OUTPUT
  dev.copy(png, file="plot4.png", width=480, height=480)
  dev.off()
}

plot4()