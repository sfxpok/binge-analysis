library(ggplot2)
library(scales)
library(lubridate)

##########################################################
########### Make sure that the time and date   ###########
########### column are in "character" datatype ###########
##########################################################

bWatchData = generalData_1310_mean # change the second variable to the imported data variable

### data treatment ###

colnames(bWatchData) <- make.names(names(bWatchData)) # making sure the dataframe columns do not have spaces
bWatchData$time <- gsub('.{4}$', '', bWatchData$time) # remove miliseconds
bWatchData["dateTime"] <- as.POSIXct(paste(date(bWatchData$date), bWatchData$time), format="%Y-%m-%d %H:%M:%S") # create a date/time POSIXct column
# bWatchData["dateTime"] <- as.POSIXct(paste(mdy(bWatchData$date), bWatchData$time), format="%Y-%m-%d %H:%M:%S") # use this if anything goes wrong
# bWatchData$hr <- as.numeric(levels(bWatchData$hr))[bWatchData$hr] # convert factor to numeric datatype

######################

ggplot(bWatchData, aes(x=dateTime, y=hr, group=1)) +
  geom_line(size = 0.5, colour = "red") +
  # geom_smooth(method = "lm") + # linear smooth
  ggtitle("Heartrate") +
  labs(x = "Time", y = "BPM") +
  scale_x_datetime(breaks = date_breaks("15 min"), minor_breaks=date_breaks("15 min"), labels=date_format("%H:%M")) + 
  theme_bw()
