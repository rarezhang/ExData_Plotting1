# Loading the data
## only be using data from the dates 2007-02-01 and 2007-02-02
file <- "household_power_consumption.txt"
colnames <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
colclass <- c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
nrows <- 1440*2 ## one-minute sampling rate, 1440 obs per day
### 2007-02-01: rows starting at: 66638
pow_consum <- read.table(file,           
           sep = ";",
           col.names = colnames,
           colClasses = colclass,
           na.strings = "?",
           nrows = nrows,
           skip = 66637)
### combine the Date and Time column into a new column
pow_consum <- cbind(paste(pow_consum$Date,pow_consum$Time),pow_consum)
### remove Date and Time column
pow_consum <- subset(pow_consum, select=-c(Date,Time))
### rename the new Date_Time column
colnames(pow_consum)[1] <- "Date_Time"
### convert the Date and Time variables to Date/Time classes
pow_consum$Date_Time <- strptime(pow_consum$Date_Time, "%d/%m/%Y %H:%M:%S")



# Making Plots 2
png('plot2.png',width=480,height=480,units="px",bg = "transparent")
plot(x = pow_consum$Date_Time,
     y = pow_consum$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatt)")
#dev.copy(png, file = "plot2.png",width=480,height=480)  ## Copy plot to a PNG file
dev.off()
