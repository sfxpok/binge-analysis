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
# bWatchData$hr <- as.numeric(levels(bWatchData$hr))[bWatchData$hr] # convert factor to numeric datatype

# bWatchData$gyro.x <-as.numeric(levels(bWatchData$gyro.x)[bWatchData$gyro.x]) # convert factor to numeric datatype
# bWatchData$gyro.y <-as.numeric(levels(bWatchData$gyro.y)[bWatchData$gyro.y]) # convert factor to numeric datatype
# bWatchData$gyro.z <-as.numeric(levels(bWatchData$gyro.z)[bWatchData$gyro.z]) # convert factor to numeric datatype

######################

ggplot(bWatchData, aes(x=dateTime, group=1)) +
  geom_line(data=bWatchData, aes(y=gyro_x, color="x"), size = 0.5) +
  geom_line(data=bWatchData, aes(y=gyro_y, color="y"), size = 0.5) +
  geom_line(data=bWatchData, aes(y=gyro_z, color="z"), size = 0.5) +
  ggtitle("Gyroscope") +
  labs(x = "Time") +
  scale_x_datetime(breaks = date_breaks("15 min"), minor_breaks=date_breaks("15 min"), labels=date_format("%H:%M")) + 
  # scale_y_continuous(limits = c(65, 100)) +
  # scale_y_continuous(limits = c(-60, 60)) + 
  scale_color_manual(values = c("blue","red","black")) +
  theme_bw() + 
  theme(axis.title.y=element_blank(), legend.title=element_blank())
