

fn <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

fl <- tempfile()
download.file(fn, fl)   # Download the file
file <- unzip(fl)       # Unzip it
unlink(fl)

# Read the file
pwr <- read.table(file, header = TRUE, stringsAsFactors = FALSE, sep = ";")

pwr$Global_active_power <- as.numeric(pwr$Global_active_power)
pwr$Date <- as.Date(pwr$Date, "%d/%m/%Y")

x <- subset(pwr, pwr$Date == "2007-02-01" | pwr$Date == "2007-02-02", 
            select=c(Global_active_power, Date, Time))


x$DT <- as.POSIXct(strptime(paste(x$Date, x$Time), format = "%Y-%m-%d %H:%M:%S"))

png(filename = "plot2.png", width = 480, height = 480)

plot(x$DT, x$Global_active_power, ylab = "Global Active Power (kilowatts)", 
     type="l", xlab="")

dev.off()