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



# Making Plots 4
png('plot4.png',width=480,height=480,units="px",bg = "transparent")
par(mfrow = c(2, 2)) # 2x2 (row wise)


plot(x = pow_consum$Date_Time,
     y = pow_consum$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatt)")

plot(x = pow_consum$Date_Time,
     y = pow_consum$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

plot(x=pow_consum$Date_Time,
     y=pow_consum$Sub_metering_1,
     col="black",
     type="l",
     xlab="",
     ylab="Energy sub metering",
     bg="transparent")
points(x=pow_consum$Date_Time,
       y=pow_consum$Sub_metering_2,
       col="red",type="l")
points(x=pow_consum$Date_Time,
       y=pow_consum$Sub_metering_3,
       col="blue",type="l")
par(mar = c(1, 2, 0, 2)) # margin for the legend
legend("topright",       
       lty = 1, # solid line
       cex = 1, # font size
       y.intersp = 1, # line spacing
       bty = "n",
       col = c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
par(mar=c(5.1, 4.1, 4.1, 2.1))

plot(x = pow_consum$Date_Time,
     y = pow_consum$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

dev.off()