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

png(filename = "plot2.png", width = 480, height = 480, units = 'px')
with(desired_data, plot(DateTime, Global_active_power, type = 'l', ylab = 'Global Active Power (kilowatts)', xlab = ''))

dev.off()
