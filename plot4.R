if(!file.exists(".//download/data.zip")){
  if(!file.exists("download")){
       dir.create("download")
   }
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                 destfile = ".//download/data.zip")
}

dataset <- read.csv(unzip (".//download/data.zip"),sep = ";") 
dataset$Date <- as.Date(dataset$Date,"%d/%m/%Y") 
selected_date <- subset(dataset, Date == "2007-02-01" | Date == "2007-02-02")
selected_date$Global_active_power <- as.numeric(as.character(selected_date$Global_active_power))
selected_date$Sub_metering_1 <- as.numeric(as.character(selected_date$Sub_metering_1))
selected_date$Sub_metering_2 <- as.numeric(as.character(selected_date$Sub_metering_2))
selected_date$Sub_metering_3 <- as.numeric(as.character(selected_date$Sub_metering_3))
selected_date$Voltage <- as.numeric(as.character(selected_date$Voltage))
selected_date$Global_reactive_power <- as.numeric(as.character(selected_date$Global_reactive_power))
xtime <- paste(selected_date$Date,selected_date$Time) 
selected_date$Time <- strptime(xtime,"%Y-%m-%d %H:%M:%S")
selected_date$Time <- as.numeric(selected_date$Time)


png(filename = "plot4.png",width = 480, height = 480)
par(mfrow = c(2,2))
#plot 01
plot(selected_date$Time, selected_date$Global_active_power, type = "l", xaxt = "n",xlab="", ylab = "Global Active Power (kilowatts)")
axis(1, at = c(1170284400, 1170371270, 1170457140 ), labels = c("Thu", "Fri", "Sat"))
#plot 02
plot(selected_date$Time, selected_date$Voltage, type = "l", xaxt = "n",xlab= "datetime", ylab = "Voltage")
axis(1, at = c(1170284400, 1170371270, 1170457140 ), labels = c("Thu", "Fri", "Sat"))
#plot 03
plot(selected_date$Time, selected_date$Sub_metering_1, type = "l",xaxt = "n",xlab='', ylab = "Energy sub metering")
lines(selected_date$Time,selected_date$Sub_metering_2,type="l",col="red")
lines(selected_date$Time,selected_date$Sub_metering_3,type="l",col="blue")
legend("topright",lty=c(1,1),lwd=c(2.0,2.0), col = c("black","red","blue"),legend  = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
axis(1,at = c(1170284400,1170371270,1170457140),labels = c("Thu", "Fri", "Sat"))
#plot 4
plot(selected_date$Time, selected_date$Global_reactive_power, type = "l", xaxt = "n",xlab= "datetime", ylab = "Global_reactive_power")
axis(1, at = c(1170284400, 1170371270, 1170457140 ), labels = c("Thu", "Fri", "Sat"))
dev.off()