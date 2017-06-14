
library(devtools)
library(twitteR)
library(tm)
library(ggmap)
library(rvest)
library(dplyr)
library(reshape2)
library(ggplot2)
library(lubridate)

consumer_key = "5Qo0Qsd7NFxIY5sWvkBoTDeKa"
consumer_secret = "k9CJTOSaTWzJ1SYhHDSidwDCfWREhj892EBugLkDsWlr7Mp5JE"
access_token = "872425018671673344-6L05NyRyrRDn65GiZmwLAkYkVFwVxJk"
access_secret = "xrZoAUzByUzzZ9hyHlAfiE15CZTgnXrV9qfVpT7ktE2jM"
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)


library(RCurl)

Date  = Sys.Date()
Year = year(Date)
Month = month(Date)
Day = day(Date)
weather <- getURL( sprintf("https://www.wunderground.com/history/airport/FACT/%s/%s/%s/DailyHistory.html?format=1", Year, Month, day))
if(0){
  newweather = read.csv(textConnection(weather), header = T)
  newweather$TimeSAST = strptime(newweather$TimeSAST, "%I:%M %p")
  myweather = rbind(myweather, newweather)
}
myweather <- read.csv(textConnection(weather), header=T)
head(myweather)
avg_temp = mean(myweather$TemperatureC)
myweather$TimeSAST = strptime(myweather$TimeSAST, "%I:%M %p")
ggplot(myweather, aes(x = TemperatureC, fill = Conditions)) + geom_density(alpha = .5)
n = nrow(myweather)
current_temp = myweather[n, 2]
current_cond = myweather[n, 12]
current_cond = as.character(current_cond)
DT = Sys.time()
DT = as.character(DT)
updateStatus(sprintf("%s \n The current temperature is: %sC \n The current conditions are %s", DT, current_temp, current_cond))

