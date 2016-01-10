## Plotting Global Active Power

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

png("plot2.png", width = 480, height = 480)
plot(dat_sub$Time, dat_sub$Global_active_power, xlab = "", 
     ylab = "Global Active Power (kilowatts)", type = "n")
lines(dat_sub$Time,dat_sub$Global_active_power)
dev.off()