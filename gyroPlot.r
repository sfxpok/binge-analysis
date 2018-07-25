library(ggplot2)
library(scales)
library(lubridate)

generalData_1335_mean$time <- gsub('.{4}$', '', generalData_1335_mean$time) # remove miliseconds
generalData_1335_mean["dateTime"] <- as.POSIXct(paste(mdy(generalData_1335_mean$date), generalData_1335_mean$time), format="%Y-%m-%d %H:%M:%S") # create a date/time POSIXct column
generalData_1335_mean$hr <- as.numeric(levels(generalData_1335_mean$hr))[generalData_1335_mean$hr] # convert factor to numeric datatype

generalData_1335_mean$gyro.x <-as.numeric(levels(generalData_1335_mean$gyro.x)[generalData_1335_mean$gyro.x]) # convert factor to numeric datatype
generalData_1335_mean$gyro.y <-as.numeric(levels(generalData_1335_mean$gyro.y)[generalData_1335_mean$gyro.y]) # convert factor to numeric datatype
generalData_1335_mean$gyro.z <-as.numeric(levels(generalData_1335_mean$gyro.z)[generalData_1335_mean$gyro.z]) # convert factor to numeric datatype

ggplot(generalData_1335_mean, aes(x=dateTime, group=1)) +
  geom_line(data=generalData_1335_mean, aes(y=gyro.x, color="x"), size = 0.5) +
  geom_line(data=generalData_1335_mean, aes(y=gyro.y, color="y"), size = 0.5) +
  geom_line(data=generalData_1335_mean, aes(y=gyro.z, color="z"), size = 0.5) +
  ggtitle("Gyroscope") +
  labs(x = "Time") +
  scale_x_datetime(breaks = date_breaks("15 min"), minor_breaks=date_breaks("15 min"), labels=date_format("%H:%M")) + 
  # scale_y_continuous(limits = c(65, 100)) +
  scale_y_continuous(limits = c(-60, 60)) + 
  scale_color_manual(values = c("blue","red","black")) +
  theme_bw() + 
  theme(axis.title.y=element_blank(), legend.title=element_blank())
