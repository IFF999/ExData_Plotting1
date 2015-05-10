## Data set downloaded from the UC Irvine Machine Learning Repository
##https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

power_consumption <<- read.table("household_power_consumption.txt", sep=";", header=TRUE)
p_c_df <<- data.frame(p_c, stringsAsFactors=FALSE)
newDates <<- p_c_df$Date >= strptime("01/02/2007 00:00:00","%d/%m/%Y %H:%M:%S") & p_c_df$Date < strptime("2007/02/03 00:00:00","%Y/%m/%d %H:%M:%S")

# subset the desired rows
p_c_temp_df <<- p_c_df[newDates,1:9]

## use rows 66637 , 69516
p_c_f_df <<- p_c_temp_df[1:2880,1:9]

plot_df <<- subset(p_c_f_df, weekdays(p_c_f_df$Date) == "Thursday" || weekdays(p_c_f_df$Date) == "Friday" || weekdays(p_c_f_df$Date) == "Saturday", select = c("Date","Sub_metering_1","Sub_metering_2","Sub_metering_3") )

plot_df$Sub_metering_1 <- as.numeric(as.character(plot_df$Sub_metering_1))
plot_df$Sub_metering_2 <- as.numeric(as.character(plot_df$Sub_metering_2))
plot_df$Sub_metering_3 <- as.numeric(as.character(plot_df$Sub_metering_3))

xrange <<- range(plot_df$Date)
yrange <<- range(plot_df$Sub_metering_1)

png("plot3.png", width=480, height=480)
plot(xrange, yrange, axes=TRUE, frame.plot=TRUE, pch="", type="p", breaks=2, ylab="Energy sub metering", xlab=NA)
axis(1, at=c(2007-02-01, 2007-02-02,2007-02-03) , lab=c("Thu", "Fri", "Sat"))
axis(2, at=c(0,2,4,6), lab=c("0", "2", "4", "6"))
lines(plot_df$Date, plot_df$Sub_metering_1, col="gray56", pch="|")
lines(plot_df$Date, plot_df$Sub_metering_2, col="red", pch="|")
lines(plot_df$Date, plot_df$Sub_metering_3, col="blue", pch="|")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1), col=c("gray56","red","blue"))
dev.off()

