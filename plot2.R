library(readr)
library(dplyr)
library(lubridate)

start_dt <- ymd('2007/2/1')
end_dt <- ymd('2007/2/2')

df <- read_csv2('household_power_consumption.txt', col_names = TRUE, na = '?', progress = TRUE, col_types='ccccccccc')
dfs <- filter(df,dmy(Date) <= end_dt & dmy(Date) >= start_dt)
dfs$datetime <- strptime(paste(dfs$Date, dfs$Time), format = '%d/%m/%Y %H:%M:%S')

plot(x = dfs$datetime, y = dfs$Global_active_power, type='l', xaxt='n', ylab = 'Global Active Power (kilowatts)')
