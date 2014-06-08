#The script assumes that the data is already on R working directory
#and that the extracted file mantains it's original name
# im going to use the function "fread", in order to do so you must
# have installed the library ("data.table") via install.packages ("data.table")

dates <- c('1/2/2007','2/2/2007')
#subsetting the data using the dates i need
power_data <- fread("household_power_consumption.txt")[Date %in% dates]
#converting from character to date format
power_data$Date <- as.Date(power_data$Date, "%d/%m/%Y")
#converting from character to numeric in order to do the histogram
power_data$Global_active_power <-as.numeric(power_data$Global_active_power)
#calling the device and doing the graph
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(power_data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
