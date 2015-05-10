## Data set downloaded from the UC Irvine Machine Learning Repository
##https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

power_consumption <<- read.table("household_power_consumption.txt", sep=";", header=TRUE)
p_c_df <<- data.frame(p_c, stringsAsFactors=FALSE)
newDates <<- p_c_df$Date >= strptime("01/02/2007 00:00:00","%d/%m/%Y %H:%M:%S") & p_c_df$Date < strptime("2007/02/03 00:00:00","%Y/%m/%d %H:%M:%S")

# subset the desired rows
p_c_temp_df <<- p_c_df[newDates,1:9]

## use rows 66637 , 69516
p_c_f_df <<- p_c_temp_df[1:2880,1:9]

x <<- as.numeric(as.character(p_c_f_df$Global_active_power))

png("plot1.png", width=480, height=480)
hist(x, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()

