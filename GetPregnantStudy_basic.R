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

        nameplot <- sprintf("basaltemp_cycle%i.jpg", ciclenum)
        
        # so turn off clipping:
        # Add extra space to right of plot area; change clipping to figure
        # par(mar=c(5.1, 4.1, 4.1, 8.1), xpd=TRUE)
        par(xpd=T, mar=par()$mar+c(0,0,0,5))
        #par(xpd=TRUE)
        
        # Open device
        #png(file = nameplot, width=600, height=400)
        jpeg(file = nameplot, width=600, height=400)
        
        # Simple Plot
        #plot(datapercicle$Temperature~datapercicle$CicleDay, type="p", pch = 3, ylab="Temperature(C)", xlab="Cicle day")
        # Background
        #par(bg = 'lightgray')
        
        with(datapercicle, plot(CicleDay, Temperature, main = "", type = "n"))
        with(subset(datapercicle, Cervical_mucus_aspect == "P"), points(CicleDay, Temperature, col = "red", cex = 1.5))

        with(subset(datapercicle, Cervical_mucus_aspect == "W" & Sex == "Y"), points(CicleDay, Temperature, pch = 19, col = "green", cex = 1.5))
        with(subset(datapercicle, Cervical_mucus_aspect == "W" & Sex == "N"), points(CicleDay, Temperature, pch = 1, col = "green", cex = 1.5))

        with(subset(datapercicle, Cervical_mucus_aspect == "D" & Sex == "Y"), points(CicleDay, Temperature, pch = 19, col = "black", cex = 1.5))
        with(subset(datapercicle, Cervical_mucus_aspect == "D" & Sex == "N"), points(CicleDay, Temperature, pch = 1, col = "black", cex = 1.5))

        with(subset(datapercicle, Cervical_mucus_aspect == "S" & Sex == "Y"), points(CicleDay, Temperature, pch = 19, col = "blue", cex = 1.5))
        with(subset(datapercicle, Cervical_mucus_aspect == "S" & Sex == "N"), points(CicleDay, Temperature, pch = 1, col = "blue", cex = 1.5))
        
        grid()
        
        #symbols(inches=1/3, ann=F, bg="steelblue2", fg=NULL)

        # Find the ovulation day and plot a line in the plot
        days <- datapercicle$CicleDay
        ovulationday <- max(days, na.rm = TRUE) - 14

        abline(v=ovulationday, col="green")

        legend("bottomright", pch = 1, col = c("red","black","green","blue"), legend = c("Period","Dry","Wet","Sticky rice"))
        legend("topleft", legend = c("Full marks: sex","Green line: ovulation day"))
        
        #legend(3.2, 1, pch = 1, col = c("red","black","green","blue"), legend = c("Period","Dry","Wet","Sticky rice"))
        #legend("topleft", inset=c(0,-0.2), legend = c("Full marks: sex","Green line: ovulation day"))
        
        
        #mtext(c("(Full marks means sex)"),side=2,line=2,at=c(1))
        #text(c(2,37), labels = c("(Full marks: sex)"))
        
        # Find the months and display as title
        month <- months(datapercicle$Date)
        # Do not know why 3 works and 1 not!!!
        initmonth <- month[3]
        lastmonth <- month[(length(month)-3)]
        
        #text(2,12, expression(paste("Chart of", initmonth)), adj=1)
        #text(2,12, paste("-", lastmonth), adj=0)
        mtext(bquote( .(initmonth) - .(lastmonth)),side=3,line=1,at=c(2))
        
        
        # Close the device
        dev.off()
        
        #rm(initmonth)
        #rm(lastmonth)
        
}

comparecycle <- function() {
        
        # Upload data
        data <- read.csv("data/body_basal_temperatures.csv", colClasses = "character")
        
        cyclenumvector <- names(table(data$CicleNumber))
        
        # Open device
        png(file = "compareall_cycles.png", width=600, height=400)
        
        # Divide the canvas in five pads
        par(mfrow = c(2,2))
        
        # Create plots with function
        #for(i in 1:length(cyclenumvector)) {
        for(i in 1:4) {
                
                basaltempstudy(i)
                
        }
        
        # Close the device
        dev.off()
        
}

ovulationdayplots <- function() {
# Function to see the ovulation day distribution
        
        # Upload data
        data <- read.csv("data/body_basal_temperatures.csv", colClasses = "character")     
        
        # Convert date and time from character to R Date
        data$Date <- as.Date(data$Date, "%d/%m/%Y")
        
        # Convert columns as numeric
        data[, c(1,4,5)] <- sapply(data[, c(1,4,5)], as.numeric)
        
        cyclenumvector <- names(table(data$CicleNumber))
        
        ovulationdays <- vector()
        
        for(i in 1:5) {
        #for(i in 1:length(cyclenumvector)) {
                
                #Subset per cicle
                datapercicle <- data[(data$CicleNumber == i), ]
                
                # Find the ovulation day
                days <- datapercicle$CicleDay
                ovulationdays[i] <- max(days, na.rm = TRUE) - 14
                
        }
        
        hist(ovulationdays, breaks = 30, xlim = c(1, 30), col = "lightblue", border = "pink", main = "Ovulation days distribution", xlab = "Cycle day number")
        
        
        
} 


















