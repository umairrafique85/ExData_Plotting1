library(tidyr)
library(dplyr)

currdir <- dirname(parent.frame(2)$ofile)
setwd(currdir)

energydata <- read.table('household_power_consumption.txt', sep = ';', header = T, na.strings = "?")

names(energydata) <- make.names(names(energydata))

desired_data <- filter(energydata, Date == '1/2/2007' | Date == '2/2/2007')

rm(energydata)

png(filename = "plot1.png", width = 480, height = 480, units = 'px')
hist(desired_data$Global_active_power, xlab = 'Global Active Power (kilowatts)', ylab = 'Frequency', main = 'Global Active Power', col = 'red')

dev.off()
