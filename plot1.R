library(readr)
library(dplyr)
library(lubridate)

start_dt <- as.Date('2007-02-01','%Y-%m-%d')
end_dt <- as.Date('2007-02-02','%Y-%m-%d')

df <- read_csv2('household_power_consumption.txt', col_names = TRUE, na = '?', progress = TRUE, col_types='ccccccccc')
dfs <- filter(df,dmy(Date) <= ymd(end_dt) & dmy(Date) >= ymd(start_dt))

png(filename = 'plot1.png', width=480, height=480, units='px')
hist(as.numeric(dfs$Global_active_power),col='red', main='Global Active Power', xlab='Global Active Power (kilowatts)')
dev.off()

rm(list=ls())
