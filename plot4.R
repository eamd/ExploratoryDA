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

plot1 <- function(x)
{
  with(x, plot(datetime,Voltage, type='l'))
}

plot2 <- function(x)
{
  with(x, plot(datetime, Global_active_power, type='l', xlab='', ylab='Global Active Power (kilowatts)'))
}

plot3 <- function(x)
{
  with(x, plot(datetime, Sub_metering_1, type='l', col='black', ylab='Energy sub metering', xlab=''))
  with(x, lines(datetime, Sub_metering_2, col='red'))
  with(x, lines(datetime, Sub_metering_3, col='blue'))
  legend('topright', bty='n', lwd=1, col=c('black', 'red', 'blue'), legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
}

plot4 <- function(x)
{
  with(x, plot(datetime,Global_reactive_power, type='l'))
}

pkgTest('readr')
pkgTest('dplyr')
pkgTest('lubridate')

start_dt <- ymd('2007/2/1')
end_dt <- ymd('2007/2/2')

df <- read_csv2('household_power_consumption.txt', col_names = TRUE, na = '?', progress = TRUE, col_types='ccccccccc')
dfs <- filter(df,dmy(Date) <= end_dt & dmy(Date) >= start_dt)
dfs$datetime <- strptime(paste(dfs$Date, dfs$Time), format = '%d/%m/%Y %H:%M:%S')

png(filename = 'plot4.png', width=480, height=480, units='px')
par(mfrow=c(2,2))
plot2(dfs)
plot1(dfs)
plot3(dfs)
plot4(dfs)
dev.off()
rm(list=ls())