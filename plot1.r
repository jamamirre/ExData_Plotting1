 if(!file.exists("download")){
  dir.create("download")
}
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = ".//download/data.zip")
dataset <- read.csv(unzip (".//download/data.zip"),sep = ";") 
dataset$Date <- as.Date(dataset$Date,"%d/%m/%Y") 
selected_date <- subset(dataset, Date == "2007-02-01" | Date == "2007-02-02")
selected_date$Global_active_power <- as.numeric(as.character(selected_date$Global_active_power))
png(filename = "plot1.png",width = 480, height = 480)
hist(selected_date$Global_active_power,col="red", main = "Global Active Power",xlab = "Global Active Power (kilowatts)" )
dev.off()