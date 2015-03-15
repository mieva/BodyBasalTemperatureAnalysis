## Script to analyze body basal temperature dataset

basaltempstudy <- function(ciclenum) {

        # Upload data
        data <- read.csv("data/body_basal_temperatures.csv", colClasses = "character")
        #na.omit(data)

        # Convert date and time from character to R Date
        data$Date <- as.Date(data$Date, "%d/%m/%Y")

        # Convert columns as numeric
        data[, c(1,4,5)] <- sapply(data[, c(1,4,5)], as.numeric)

        #Subset per cicle
        datapercicle <- data[(data$CicleNumber == ciclenum), ]

        nameplot <- sprintf("basaltemp_cycle%i.png", ciclenum)
        
        # Open device
        png(file = nameplot, width=600, height=400)
        
        # Simple Plot
        #plot(datapercicle$Temperature~datapercicle$CicleDay, type="p", pch = 3, ylab="Temperature(C)", xlab="Cicle day")

        with(datapercicle, plot(CicleDay, Temperature, main = "", type = "n"))
        with(subset(datapercicle, Cervical_mucus_aspect == "P"), points(CicleDay, Temperature, col = "red"))

        with(subset(datapercicle, Cervical_mucus_aspect == "W" & Sex == "Y"), points(CicleDay, Temperature, pch = 19, col = "green"))
        with(subset(datapercicle, Cervical_mucus_aspect == "W" & Sex == "N"), points(CicleDay, Temperature, pch = 1, col = "green"))

        with(subset(datapercicle, Cervical_mucus_aspect == "D" & Sex == "Y"), points(CicleDay, Temperature, pch = 19, col = "black"))
        with(subset(datapercicle, Cervical_mucus_aspect == "D" & Sex == "N"), points(CicleDay, Temperature, pch = 1, col = "black"))

        with(subset(datapercicle, Cervical_mucus_aspect == "S" & Sex == "Y"), points(CicleDay, Temperature, pch = 19, col = "blue"))
        with(subset(datapercicle, Cervical_mucus_aspect == "S" & Sex == "N"), points(CicleDay, Temperature, pch = 1, col = "blue"))

        # Find the ovulation day and plot a line in the plot
        days <- datapercicle$CicleDay
        ovulationday <- max(days, na.rm = TRUE) - 14

        abline(v=ovulationday, col="green")

        legend("bottomright", pch = 1, col = c("red","black","green","blue"), legend = c("Period","Dry","Wet","Sticky rice"))
        legend("topleft", legend = c("Full marks: sex","Green line: ovulation day"))
        #mtext(c("(Full marks means sex)"),side=1,line=2,at=c(1))
        #text(c(2,37), labels = c("(Full marks: sex)"))
        
        # Close the device
        dev.off()
        
}


















