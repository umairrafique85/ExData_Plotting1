library(tidyr)
library(dplyr)

currdir <- dirname(parent.frame(2)$ofile)
setwd(currdir)

energydata <- read.table('household_power_consumption.txt', sep = ';', header = T, na.strings = "?")

names(energydata) <- make.names(names(energydata))

desired_data <- filter(energydata, Date == '1/2/2007' | Date == '2/2/2007')

DesiredDateTime <- desired_data[, c("Date", "Time")] %>% unite(DateTime, Date, Time)
DesiredDateTime$DateTime <- strptime(DesiredDateTime$DateTime,
                                     "%d/%m/%Y_%H:%M:%S")

desired_data$DateTime <- DesiredDateTime$DateTime

png(filename = "plot4.png", width = 480, height = 480, units = 'px')

par(mfcol = c(2, 2))

with(desired_data, plot(DateTime, Global_active_power, type = 'l', ylab = 'Global Active Power (kilowatts)', xlab = ''))

with(desired_data, plot(DateTime, Sub_metering_1, type = 'n', ylab = 'Energy sub metering', xlab = ''))

points(desired_data$DateTime, desired_data$Sub_metering_1, type = 'l')
points(desired_data$DateTime, desired_data$Sub_metering_2, type = 'l', col = 'red')
points(desired_data$DateTime, desired_data$Sub_metering_3, type = 'l', col = 'purple')

legend('topright', lty = c(1, 1, 1), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col = c('black', 'red', 'purple'), border = 'none')

with(desired_data, plot(DateTime, Voltage, type = 'l', ylab = 'Voltage', xlab = 'datetime'))

with(desired_data, plot(DateTime, Global_reactive_power, type = 'l', ylab = 'Global reactive power', xlab = 'datetime'))

dev.off()
