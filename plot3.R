#The script assumes that the data is already on R working directory
#and that the extracted file mantains it's original name
power_data <-read.table("household_power_consumption.txt",sep = ";", header = TRUE, stringsAsFactors= FALSE, colClasses= c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),na.strings="?") 
#converting dates into a date format
dates <- as.Date(power_data[,1], "%d/%m/%Y")
#subsetting to the dates i want
#Search for dates 2007-02-02 y 2007-02-02
Done <- grep ("2007-02-01",dates, value = FALSE)
Dtwo <- grep ("2007-02-02",dates, value = FALSE)
rows <- cbind(Done,Dtwo)
install.packages ("reshape2")
library ("reshape2")
rows <- melt(rows)
rows <- rows [,3]
#subsetting the dates i need
sub_data <- power_data [rows,]
#Changing the timezone values to US
Sys.setlocale("LC_TIME", "C")
coltime <- strptime(paste(sub_data$Date, sub_data$Time), "%d/%m/%Y %H:%M:%S",tz = "GMT") 
Nsub_data<- cbind (coltime,sub_data)
png(filename = "plot3.png", width = 480, height = 480, units = "px")
plot(Nsub_data$coltime, Nsub_data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(Nsub_data$coltime, Nsub_data$Sub_metering_2, type="l", col = "red")
lines(Nsub_data$coltime, Nsub_data$Sub_metering_3, type="l", col = "blue")
legend("topright",lty = 1, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()