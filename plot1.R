library(tidyr)
library(dplyr)

energydata <- read.table('household_power_consumption.txt', sep = ';', header = T, na.strings = "?")

names(energydata) <- make.names(names(energydata))

desired_data <- filter(energydata, Date == '1/2/2007' | Date == '2/2/2007')

# DesiredDateTime <- desired_data[, c("Date", "Time")] %>% unite(DateTime, Date, Time)
# DesiredDateTime$DateTime <- strptime(DesiredDateTime$DateTime,
#                                       "%d/%m/%Y_%H:%M:%S")

rm(energydata)

hist(desired_data$Global_active_power, xlab = 'Global Active Power (kilowatts)', ylab = 'Frequency', main = 'Global Active Power', col = 'red')
