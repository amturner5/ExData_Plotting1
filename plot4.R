##download from url and unzip to local repository
url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
download.file(url, "C:/Users/Dell/test-repo/EDAProgrammingAssignment1/ExData_Plotting1/household_power_consumption.zip")
unzip("C:/Users/Dell/test-repo/EDAProgrammingAssignment1/ExData_Plotting1/household_power_consumption.zip")

file <- "C:/Users/Dell/test-repo/EDAProgrammingAssignment1/ExData_Plotting1/household_power_consumption.txt"
##read in indicated dates
library(sqldf)
df <- read.csv.sql(file, "select * from file where Date = '2/2/2007' or Date = '1/2/2007'", 
                   header = TRUE, sep = ";")

##concatenate date and time and convert to posixlt type
df$Date_Time <- paste(df$Date, df$Time)
df$Date_Time <- strptime(df$Date_Time, "%d/%m/%Y %H:%M:%S")

##open graphics viewer and create plot
png("C:/Users/Dell/test-repo/EDAProgrammingAssignment1/ExData_Plotting1/plot4.R.png", height = 480, width = 480)

par(mfrow=c(2,2))
with(df, plot(Date_Time, Global_active_power, type = "n", ylab = "Global Active Power (kilowatts)", xlab = ""))
lines(df$Date_Time, df$Global_active_power, type = "l'")

with(df, plot(Date_Time, Voltage, type = "n", ylab = "Voltage", xlab = "datetime"))
lines(df$Date_Time, df$Voltage, type = "l'")

with(df, plot(Date_Time, Sub_metering_1, type = "n", ylab = "Energy of Sub Metering", xlab = ""))
lines(df$Date_Time, df$Sub_metering_1, type = "l", col = "black")
lines(df$Date_Time, df$Sub_metering_2, type = "l", col = "red")
lines(df$Date_Time, df$Sub_metering_3, type = "l", col = "blue")
legend("topright", border = "clear", cex = 0.5, lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") )

with(df, plot(Date_Time, Global_reactive_power, type = "n", ylab = "Global_Reactive_Power", xlab = "datetime"))
lines(df$Date_Time, df$Global_reactive_power, type = "l")
dev.off()