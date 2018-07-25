library(ggplot2)
library(scales)
library(lubridate)

generalData_1335_mean$time <- gsub('.{4}$', '', generalData_1335_mean$time) # remove miliseconds
generalData_1335_mean["dateTime"] <- as.POSIXct(paste(mdy(generalData_1335_mean$date), generalData_1335_mean$time), format="%Y-%m-%d %H:%M:%S") # create a date/time POSIXct column
generalData_1335_mean$hr <- as.numeric(levels(generalData_1335_mean$hr))[generalData_1335_mean$hr] # convert factor to numeric datatype

generalData_1335_mean$accel.x <-as.numeric(levels(generalData_1335_mean$accel.x)[generalData_1335_mean$accel.x]) # convert factor to numeric datatype
generalData_1335_mean$accel.y <-as.numeric(levels(generalData_1335_mean$accel.y)[generalData_1335_mean$accel.y]) # convert factor to numeric datatype
generalData_1335_mean$accel.z <-as.numeric(levels(generalData_1335_mean$accel.z)[generalData_1335_mean$accel.z]) # convert factor to numeric datatype

ggplot(generalData_1335_mean, aes(x=dateTime, group=1)) +
  geom_line(data=generalData_1335_mean, aes(y=accel.x, color="x"), size = 0.5) +
  geom_line(data=generalData_1335_mean, aes(y=accel.y, color="y"), size = 0.5) +
  geom_line(data=generalData_1335_mean, aes(y=accel.z, color="z"), size = 0.5) +
  ggtitle("Accelerometer") +
  labs(x = "Time") +
  scale_x_datetime(breaks = date_breaks("15 min"), minor_breaks=date_breaks("15 min"), labels=date_format("%H:%M")) + 
  # scale_y_continuous(limits = c(65, 100)) +
  scale_y_continuous(limits = c(-10, 10)) + 
  scale_color_manual(values = c("blue","red","black")) +
  theme_bw() + 
  theme(axis.title.y=element_blank(), legend.title=element_blank())
