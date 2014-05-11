# Set working directory:
setwd("C:\\Users\\Vadim\\Documents\\LikBez\\Coursera\\04_Exploratory_Data_Analysis\\Homework1")

## Read the data set into memory:
fileName <- "household_power_consumption.txt"
df <- read.table(fileName, header=TRUE, sep=";", na.strings="?")

## Filter out the 2 days of interest (2007/02/01 and 02):
tmp <- rbind(df[df$Date=="1/2/2007",], df[df$Date=="2/2/2007",])

## Conver character to Date and time for Date and Time columns, respectively:
sample <- data.frame(
    Date=as.Date(tmp$Date, "%d/%m/%Y"),
    Time=strptime(paste(tmp$Date, tmp$Time, sep=""), "%d/%m/%Y %H:%M:%S"),
    GlobalActivePower=tmp$Global_active_power,
    GlobalReactivePower=tmp$Global_reactive_power, 
    Voltage=tmp$Voltage,
    GlobalIntensity=tmp$Global_intensity,
    SubMetering1=tmp$Sub_metering_1,
    SubMetering2=tmp$Sub_metering_2,
    SubMetering3=tmp$Sub_metering_3
)

## Open a PNG graphics device:
png("plot4.png")

par(mfrow = c(2,2))

## First graph:
plot(sample$Time, sample$GlobalActivePower, pch=".", xlab="", ylab="Global Active Power")
lines(sample$Time, sample$GlobalActivePower)

## Second graph:
plot(sample$Time, sample$Voltage, pch=".", xlab="datetime", ylab="Voltage")
lines(sample$Time, sample$Voltage)

## Third graph:
plot(sample$Time, sample$SubMetering1, xlab="", ylab="Energy sub metering", pch=".", col="black")
lines(sample$Time, sample$SubMetering1, col="black")
lines(sample$Time, sample$SubMetering2, col="red")
lines(sample$Time, sample$SubMetering3, col="blue")
legend("topright", pch="_", bty="n",
       col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
)

## Fourth graph:
plot(sample$Time, sample$GlobalReactivePower, pch=".", xlab="datetime", ylab="Global_Reactive_Power")
lines(sample$Time, sample$GlobalReactivePower)

## Close PNG graphics device (so that you don't overwrite your work!):
dev.off()