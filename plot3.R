
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

#plot 3 - Sub meterings VS Active Power VS DateTime
plot3 <- function() {

  plot(sub$DateTime,sub$"Sub_metering_1",type="l",ylab="Global Active Power (kilowatts)",xlab="")
  lines(sub$DateTime,sub$"Sub_metering_2",col=2)
  lines(sub$DateTime,sub$"Sub_metering_3",col=4)
  legend("topright", col = c(1,2,4), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),lty=c(1,1),lwd=c(1,1))
  dev.copy(png, file="plot3.png", width=480, height=480)
  dev.off()
}

plot3()
