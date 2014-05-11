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
png("plot3.png")

## Plot graph:
plot(sample$Time, sample$SubMetering1, xlab="", ylab="Energy sub metering", pch=".", col="black")
## Add lines for sub_metering_1:
lines(sample$Time, sample$SubMetering1, col="black")
## Add lines for sub_metering_2:
lines(sample$Time, sample$SubMetering2, col="red")
## Add lines for sub_metering_3:
lines(sample$Time, sample$SubMetering3, col="blue")
## Set the legend:
legend("topright", pch="_",
    col=c("black", "red", "blue"),
    legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
)

## Close PNG graphics device (so that you don't overwrite your work!):
dev.off()