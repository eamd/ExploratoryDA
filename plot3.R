pkgTest <- function(x)
{
  #
  # this routine came from a solution in stackoverflow
  # http://stackoverflow.com/questions/9341635/check-for-installed-packages-before-running-install-packages
  #
  if (!require(x,character.only = TRUE))
  {
    install.packages(x,dep=TRUE)
    if(!require(x,character.only = TRUE)) stop("Package not found")
  }
  library(x, character.only = TRUE)
}

pkgTest('readr')
pkgTest('dplyr')
pkgTest('lubridate')

start_dt <- ymd('2007/2/1')
end_dt <- ymd('2007/2/2')

df <- read_csv2('household_power_consumption.txt', col_names = TRUE, na = '?', progress = TRUE, col_types='ccccccccc')
dfs <- filter(df,dmy(Date) <= end_dt & dmy(Date) >= start_dt)
dfs$datetime <- strptime(paste(dfs$Date, dfs$Time), format = '%d/%m/%Y %H:%M:%S')

png(filename = 'plot3.png', width=480, height=480, units='px')

with(dfs, plot(datetime, Sub_metering_1, type='l', col='black', ylab='Energy sub metering', xlab=''))
with(dfs, lines(datetime, Sub_metering_2, col='red'))
with(dfs, lines(datetime, Sub_metering_3, col='blue'))
legend('topright', lwd=1, col=c('black', 'red', 'blue'), legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))

dev.off()
rm(list=ls())