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
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(sub_data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()