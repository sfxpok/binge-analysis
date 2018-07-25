library(ggplot2)
library(scales)
library(lubridate)

hrData_1335_mean$time <- gsub('.{4}$', '', hrData_1335_mean$time) # remove miliseconds
hrData_1335_mean["dateTime"] <- as.POSIXct(paste(mdy(generalData_1335_mean$date), hrData_1335_mean$time), format="%Y-%m-%d %H:%M:%S") # create a date/time POSIXct column
hrData_1335_mean$hr <- as.numeric(levels(hrData_1335_mean$hr))[hrData_1335_mean$hr] # convert factor to numeric datatype

ggplot(hrData_1335_mean, aes(x=dateTime, y=hr, group=1)) +
  geom_line(size = 0.5, colour = "red") +
  ggtitle("Heartrate") +
  labs(x = "Time", y = "BPM") +
  scale_x_datetime(breaks = date_breaks("15 min"), minor_breaks=date_breaks("15 min"), labels=date_format("%H:%M")) + 
  scale_y_continuous(limits = c(65, 100)) +
  theme_bw()
