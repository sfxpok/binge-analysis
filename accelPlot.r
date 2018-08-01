library(ggplot2)
library(scales)
library(lubridate)

##########################################################
########### Make sure that the time and date   ###########
########### column are in "character" datatype ###########
##########################################################

bWatchData = generalData_1310_mean

### Data treatment ###

colnames(bWatchData) <- make.names(names(bWatchData))
bWatchData$time <- gsub('.{4}$', '', bWatchData$time) # remove miliseconds
bWatchData["dateTime"] <- as.POSIXct(paste(date(bWatchData$date), bWatchData$time), format="%Y-%m-%d %H:%M:%S") # create a date/time POSIXct column
# bWatchData$hr <- as.numeric(levels(bWatchData$hr))[bWatchData$hr] # convert factor to numeric datatype

# bWatchData$accel.x <-as.numeric(levels(bWatchData$accel.x)[bWatchData$accel.x]) # convert factor to numeric datatype
# bWatchData$accel.y <-as.numeric(levels(bWatchData$accel.y)[bWatchData$accel.y]) # convert factor to numeric datatype
# bWatchData$accel.z <-as.numeric(levels(bWatchData$accel.z)[bWatchData$accel.z]) # convert factor to numeric datatype

######################

ggplot(bWatchData, aes(x=dateTime, group=1)) +
  geom_line(data=bWatchData, aes(y=accel.x, color="x"), size = 0.5) +
  geom_line(data=bWatchData, aes(y=accel.y, color="y"), size = 0.5) +
  geom_line(data=bWatchData, aes(y=accel.z, color="z"), size = 0.5) +
  ggtitle("Accelerometer") +
  labs(x = "Time") +
  scale_x_datetime(breaks = date_breaks("15 min"), minor_breaks=date_breaks("15 min"), labels=date_format("%H:%M")) + 
  # scale_y_continuous(limits = c(65, 100)) +
  scale_y_continuous(limits = c(-10, 10)) + 
  scale_color_manual(values = c("blue","red","black")) +
  theme_bw() + 
  theme(axis.title.y=element_blank(), legend.title=element_blank())
