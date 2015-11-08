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
xtime <- paste(selected_date$Date,selected_date$Time) 
selected_date$Time <- strptime(xtime,"%Y-%m-%d %H:%M:%S")
selected_date$Time <- as.numeric(selected_date$Time)
png(filename = "plot2.png",width = 480, height = 480)
plot(selected_date$Time, selected_date$Global_active_power, type = "l", xaxt = "n",xlab='', ylab = "Global Active Power (kilowatts)")
axis(1, at = c(1170284400, 1170371270, 1170457140 ), labels = c("Thu", "Fri", "Sat"))
dev.off()
