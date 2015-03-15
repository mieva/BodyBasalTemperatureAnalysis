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
        
        # Start with the graph
        p <- ggplot(datapercicle, aes(CicleDay, Temperature))
        p1 <- p + geom_point(aes(colour = Cervical_mucus_aspect), subset(datapercicle, Sex == "Y"), size = 4, shape = 16 ) +
              geom_point(aes(colour = Cervical_mucus_aspect), subset(datapercicle, Sex == "N"), size = 4, shape = 1) +
            #scale_fill_identity(name = "Sex", guide ="legend", labels = c("Sex","No sex")) +
              scale_colour_manual(name = 'Mucus aspect', values =c('black','red','blue', 'Green'), labels = c('Dry', 'Period','Sticky','Wet')) 
            #guides(color=guide_legend(override.aes=list(shape=c(1,16)))
            # scale_shape_manual(name = 'Sex', values = c(16,1), labels = c('Sex','No sex'))
            #geom_point(aes(CicleDay, Temperature), subset(datapercicle,Sex == "Y",group=Sex, shape=Sex), size = 4, shape = 8)
            #scale_shape_manual(name = "Sex", values = rep(16, 1)) +
            #guides(shape = guide_legend(override.aes = list(shape = c(16, 1), size = 4)))
                
         #p2 <- p1 + geom_point(aes(size="Sex", shape = NA), colour = "grey50")
         #p2 + guides(size=guide_legend(c("Sex", override.aes=list(shape=16, size = 4))))
        
        p1 + geom_point(aes(shape="Yes"), alpha=1/16) + geom_point(aes(shape="N"), alpha=1/16) +
             scale_shape_manual(name='Sex', values=c('Yes'=16, 'N'= 1), guide='legend') +
             guides(shape = guide_legend(override.aes = list(shape=c(NA, 1), shape=c(16, NA))))
        #p2 + guides(size=guide_legend(c("Sex", override.aes=list(shape=16, size = 4))))
        
        
}


















