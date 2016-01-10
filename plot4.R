## Plotting multiple graphs

# Reading initial rows to get number of columns for faster reading later
testdat <- read.table("household_power_consumption.txt", sep = ";", 
                      na.strings = "?", header = TRUE, nrows = 5)
classes <- sapply(testdat, class)

# Reading entire data

dat <- read.table("household_power_consumption.txt", sep = ";", 
                  na.strings = "?", header = TRUE, colClasses = classes)
# Converting Date & time to respective formats

dat$Date <- as.Date(dat$Date, format = "%d/%m/%Y")
dat$Time <- paste(dat$Date, dat$Time)
dat$Time <- strptime(dat$Time, format = "%Y-%m-%d %H:%M:%S")
# Subsetting data for two days

dat_sub <- subset(dat, dat$Time >= as.POSIXlt("2007-02-01 00:00:00") 
                  & dat$Time < as.POSIXlt("2007-02-03 00:00:00"))

# Plotting to png file 

png("plot4.png", width = 480, height = 480)

par(mfcol = c (2,2))

# Plot graph 1

plot(dat_sub$Time, dat_sub$Global_active_power, xlab = "",
     ylab = "Global Active Power (kilowatts)", type = "n")
lines(dat_sub$Time,dat_sub$Global_active_power)

# Plot graph 2

plot(dat_sub$Time, dat_sub$Sub_metering_1, type = "n", 
     xlab = "", ylab = "Energy sub metering")
lines(dat_sub$Time, dat_sub$Sub_metering_1, col = "black")
lines(dat_sub$Time, dat_sub$Sub_metering_2, col = "red")
lines(dat_sub$Time, dat_sub$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2",
        "Sub_metering_3"),lty = 1, col = c("black", "red", "blue"), bty = "n")

# Plot graph 3

plot(dat_sub$Time, dat_sub$Voltage, xlab = "datetime",
     ylab = "Voltage", type = "n")
lines(dat_sub$Time, dat_sub$Voltage)

# Plot graph 4

plot(dat_sub$Time, dat_sub$Global_reactive_power, xlab = "datetime", 
     ylab = "Global_reactive_power", type = "n", yaxt = "n")
lines(dat_sub$Time, dat_sub$Global_reactive_power)
vect <- c(0.0, 0.1, 0.2, 0.3, 0.4, 0.5)
axis(side = 2, at = vect, labels = vect)

dev.off()