# Plot 3

fn <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

fl <- tempfile()
download.file(fn, fl)   # Download the file
file <- unzip(fl)       # Unzip it
unlink(fl)

# Read the file
pwr <- read.table(file, header = TRUE, stringsAsFactors = FALSE, sep = ";")

pwr$Global_active_power <- as.numeric(pwr$Global_active_power)
pwr$Sub_meterin_1       <- as.numeric(pwr$Sub_metering_1)
pwr$Sub_meterin_2       <- as.numeric(pwr$Sub_metering_2)
pwr$Sub_meterin_3       <- as.numeric(pwr$Sub_metering_3)
pwr$Date <- as.Date(pwr$Date, "%d/%m/%Y")

x <- subset(pwr, pwr$Date == "2007-02-01" | pwr$Date == "2007-02-02", 
            select=c(Date, Time, Global_active_power, Sub_metering_1,
                     Sub_metering_2, Sub_metering_3))

x$DT <- as.POSIXct(strptime(paste(x$Date, x$Time), format = "%Y-%m-%d %H:%M:%S"))

png(filename = "plot3.png", width = 480, height = 480)

plot(x$DT, x$Sub_metering_1, ylab = "Energy sub metering", 
     type="l", xlab="")

lines(x$DT, x$Sub_metering_2, col = "red")
lines(x$DT, x$Sub_metering_3, col = "blue")

legend("topright", names(x)[4:6], lty=c(1,1), 
       lwd=c(2.5,2.5),col=c("black","red", "blue")) 
dev.off()