## load libraries
install.packages("png")
library(png)

## Data set downloaded from the UC Irvine Machine Learning Repository
##https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

power_consumption <<- read.table("household_power_consumption.txt", sep=";", header=TRUE)
p_c_df <<- data.frame(p_c, stringsAsFactors=FALSE)
newDates <<- p_c_df$Date >= strptime("01/02/2007 00:00:00","%d/%m/%Y %H:%M:%S") & p_c_df$Date < strptime("2007/02/03 00:00:00","%Y/%m/%d %H:%M:%S")

# subset the desired rows
p_c_temp_df <<- p_c_df[newDates,1:9]

## use rows 66637 , 69516
p_c_f_df <<- p_c_temp_df[1:2880,1:9]


## plot 2 prep
plot2_df <<- subset(p_c_f_df, weekdays(p_c_f_df$Date) == "Thursday" || weekdays(p_c_f_df$Date) == "Friday" || weekdays(p_c_f_df$Date) == "Saturday", select = c("Date","Global_active_power") )
plot2_df$Global_active_power <- as.numeric(as.character(plot2_df$Global_active_power))

## plot 2A prep
plot2A_df <<- subset(p_c_f_df, weekdays(p_c_f_df$Date) == "Thursday" || weekdays(p_c_f_df$Date) == "Friday" || weekdays(p_c_f_df$Date) == "Saturday", select = c("Date","Voltage") )
plot2A_df$Voltage <- as.numeric(as.character(plot2A_df$Voltage))


## plot 3 prep
plot3_df <<- subset(p_c_f_df, weekdays(p_c_f_df$Date) == "Thursday" || weekdays(p_c_f_df$Date) == "Friday" || weekdays(p_c_f_df$Date) == "Saturday", select = c("Date","Sub_metering_1","Sub_metering_2","Sub_metering_3") )

plot3_df$Sub_metering_1 <- as.numeric(as.character(plot3_df$Sub_metering_1))
plot3_df$Sub_metering_2 <- as.numeric(as.character(plot3_df$Sub_metering_2))
plot3_df$Sub_metering_3 <- as.numeric(as.character(plot3_df$Sub_metering_3))

xrange <<- range(plot3_df$Date)
yrange <<- range(plot3_df$Sub_metering_1)

## plot 4 prep
plot4_df <<- subset(p_c_f_df, weekdays(p_c_f_df$Date) == "Thursday" || weekdays(p_c_f_df$Date) == "Friday" || weekdays(p_c_f_df$Date) == "Saturday", select = c("Date","Global_reactive_power") )

plot4_df$Global_reactive_power <- as.numeric(as.character(plot4_df$Global_reactive_power))

xrange4 <<- range(plot4_df$Date)
yrange4 <<- range(plot4_df$Global_reactive_power)


png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))

## plot 1
##hist(x, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

## plot 2
plot(plot2_df, axes=TRUE, frame.plot=TRUE, type="p", pch="|", ylab="Global Active Power (kilowatts)", xlab=NA)
axis(1, at=c(2007-02-01, 2007-02-02,2007-02-03) , lab=c("Thu", "Fri", "Sat"))
axis(2, at=c(0,2,4,6), lab=c("0", "2", "4", "6"))

## plot 2A
plot(plot2A_df, axes=TRUE, frame.plot=TRUE, type="p", pch="|", ylab="Voltage", xlab=NA)
axis(1, at=c(2007-02-01, 2007-02-02,2007-02-03) , lab=c("Thu", "Fri", "Sat"))
axis(2, at=c(0,2,4,6), lab=c("0", "2", "4", "6"))


## plot 3
plot(xrange, yrange, axes=TRUE, frame.plot=TRUE, pch="", type="p", ylab="Energy sub metering", xlab=NA)
axis(1, at=c(2007-02-01, 2007-02-02,2007-02-03) , lab=c("Thu", "Fri", "Sat"))
axis(2, at=c(0,2,4,6), lab=c("0", "2", "4", "6"))
lines(plot3_df$Date, plot3_df$Sub_metering_1, col="gray56", pch="|")
lines(plot3_df$Date, plot3_df$Sub_metering_2, col="red", pch="|")
lines(plot3_df$Date, plot3_df$Sub_metering_3, col="blue", pch="|")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1), col=c("gray56","red","blue"))

## plot 4
plot(xrange4, yrange4, axes=TRUE, frame.plot=TRUE, pch="", type="p", ylab="Global_reactive_power", xlab="datetime")
axis(1, at=c(2007-02-01, 2007-02-02,2007-02-03) , lab=c("Thu", "Fri", "Sat"))
axis(2, at=c(0,2,4,6), lab=c("0", "2", "4", "6"))
lines(plot4_df$Date, plot4_df$Global_reactive_power, col="black", pch="|")

dev.off()














