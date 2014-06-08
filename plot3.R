#The script assumes that the data is already on R working directory
#and that the extracted file mantains it's original name.
# Im going to use the function "fread", in order to do so, you must
# have installed the library ("data.table") via install.packages ("data.table")

dates <- c('1/2/2007','2/2/2007')
#subsetting the data using the dates i need
power_data <- fread("household_power_consumption.txt")[Date %in% dates]
#changing the timezone values in order to match the example
Sys.setlocale("LC_TIME", "C")
#Creating a new colummn that takes into account not only the day but also the hour of the day 
coltime <- strptime(paste(power_data$Date, power_data$Time), "%d/%m/%Y %H:%M:%S",tz = "GMT") 
# Creating the graph
png(filename = "plot3.png", width = 480, height = 480, units = "px")
plot(coltime, power_data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(coltime, power_data$Sub_metering_2, type="l", col = "red")
lines(coltime, power_data$Sub_metering_3, type="l", col = "blue")
legend("topright",lty = 1, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()

