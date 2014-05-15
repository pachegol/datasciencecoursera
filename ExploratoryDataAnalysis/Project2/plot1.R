
## R Code to create the first chart.


library(lattice)
library(ggplot2)

NEI <- readRDS("~./data/summarySCC_PM25.rds")
SCC <- readRDS("~./data/Source_Classification_Code.rds")


# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total 
# PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

library(dplyr)

# dplyr is much faster than base R aggregage function
by.year <- group_by(NEI, year)
data <- summarise(by.year,
                  Emissions = sum(Emissions))

data <- NEI %.% group_by(year) %.% summarise(Emissions = sum(Emissions)/1000000)

# Instead of creating a simple barplot, I wanted to add the number of top of the bar
# I think it makes more readable

png()
png(filename="plot1.png") # default is 480x480


text(x=barplot(data$Emissions,
               main = expression(paste("Total emissions from ",PM[2.5]," (in MM) in the U.S.")),
               names.arg=data$year,
               ylim = c(0,9),
               axes = FALSE)
,y=data$Emissions,label=paste(format(data$Emissions, digits=2),"M"),po=3)

dev.off()


# Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system 
# to make a plot answering this question.

library(lattice)
library(ggplot2)

NEI <- readRDS("~./data/summarySCC_PM25.rds")
SCC <- readRDS("~./data/Source_Classification_Code.rds")


library(dplyr)

# dplyr is much faster than base R aggregage function


data <- NEI %.% filter(fips == "24510") %.% group_by(year) %.% summarise(Emissions = sum(Emissions))

png()
png(filename="plot2.png") # default is 480x480


text(x=barplot(data$Emissions,
               main = expression(paste("Total emissions from ",PM[2.5]," in the Baltimore")),
               names.arg=data$year,
               ylim = c(0,4000),
               axes = FALSE)
     ,y=data$Emissions,label=format(data$Emissions, digits=2, big.mark=","),po=3)

dev.off()


# Of the four types of sources indicated by the type 
# (point, nonpoint, onroad, nonroad) variable, which of these four 
# sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
# Which have seen increases in emissions from 1999-2008? Use the ggplot2 
# plotting system to make a plot answer this question.

library(lattice)
library(ggplot2)
library(scales)

NEI <- readRDS("~./data/summarySCC_PM25.rds")
SCC <- readRDS("~./data/Source_Classification_Code.rds")


library(dplyr)

# dplyr is much faster than base R aggregage function


data <- NEI %.% filter(fips == "24510") %.% group_by(year, type) %.% summarise(Emissions = sum(Emissions))

p <-ggplot(data = data,
       mapping = aes(x = factor(year), y = Emissions)) + geom_bar(stat="identity") +
      facet_grid(. ~ type) +
    scale_x_discrete("year") +
    scale_y_continuous(labels=comma) + 
  ggtitle(expression(paste("Total emissions from ",PM[2.5]," in the Baltimore")))

ggsave(filename="Plot3.png")




library(lattice)
library(ggplot2)
library(scales)

NEI <- readRDS("~./data/summarySCC_PM25.rds")
SCC <- readRDS("~./data/Source_Classification_Code.rds")

SCC$SCC <- as.character(SCC$SCC)



data <- NEI %.% group_by(year, SCC) %.% summarise(Emissions = sum(Emissions)) %.% merge(SCC, all = TRUE) 

z <- data[grep("Coal", data$EI.Sector, perl=TRUE, value=FALSE),]

data <- z %.% group_by(year) %.% summarise(Emissions = sum(Emissions))


png()
png(filename="plot4.png") # default is 480x480


text(x=barplot(data$Emissions,
               main = expression(paste("Total emissions from coal combustion-related sources in the U.S.")),
               names.arg=data$year,
               ylim = c(0,800000),
               axes = FALSE)
     ,y=data$Emissions,label=format(data$Emissions, digits=2, big.mark=","),po=3)

dev.off()



# How have emissions from motor vehicle sources changed from 1999-2008 
# in Baltimore City?


library(lattice)
library(ggplot2)
library(scales)

NEI <- readRDS("~./data/summarySCC_PM25.rds")
SCC <- readRDS("~./data/Source_Classification_Code.rds")

SCC$SCC <- as.character(SCC$SCC)



data <- NEI %.% filter(fips == "24510") %.% group_by(year, SCC) %.% summarise(Emissions = sum(Emissions)) %.% merge(SCC, all = TRUE) 

z <- data[grep("Vehicles", data$EI.Sector, perl=TRUE, value=FALSE),]

data <- z %.% group_by(year) %.% summarise(Emissions = sum(Emissions))

data <- na.omit(data)

png()
png(filename="plot5.png") # default is 480x480


text(x=barplot(data$Emissions,
               main = expression(paste("Total emissions from motor vehicle sources in Baltimore")),
               names.arg=data$year,
               ylim = c(0,500),
               axes = FALSE)
     ,y=data$Emissions,label=format(data$Emissions, digits=2, big.mark=","),po=3)

dev.off()

# Compare emissions from motor vehicle sources in Baltimore City 
# with emissions from motor vehicle sources in Los Angeles County, 
# California (fips == 06037). Which city has seen greater 
# changes over time in motor vehicle emissions?


library(lattice)
library(ggplot2)
library(scales)
library(gridExtra)

NEI <- readRDS("~./data/summarySCC_PM25.rds")
SCC <- readRDS("~./data/Source_Classification_Code.rds")

SCC$SCC <- as.character(SCC$SCC)



data <- NEI %.% filter(fips == "06037" | fips == "24510") %.% group_by(fips, year, SCC) %.% summarise(Emissions = sum(Emissions)) %.% merge(SCC, all = TRUE) 

z <- data[grep("Vehicles", data$EI.Sector, perl=TRUE, value=FALSE),]

data <- z %.% group_by(fips,year) %.% summarise(Emissions = sum(Emissions)) %.% arrange(fips, year)

data <- na.omit(data)

data$City <- ifelse(data$fips == "06037", "Los Angeles", "Baltimore")

EmissionBase <- data$Emissions[data$year == 1999 & data$fips == data$fips]

data$EmissionBase <- ifelse(data$fips == "06037",EmissionBase[1] , EmissionBase[2])

data$CAGR_1999 <- (data$Emissions / data$EmissionBase)^(1/(data$year - 1999)) - 1


p1 <-ggplot(data = data,
           mapping = aes(x = factor(year), y = Emissions)) + geom_bar(stat="identity") +
  facet_grid(. ~ City) +
  scale_x_discrete("year") +
  scale_y_continuous(labels=comma) + 
  ggtitle("Total emissions from motor vehicle sources")

p2 <- ggplot(data = data,
             mapping = aes(x = factor(year), y = CAGR_1999)) + geom_bar(stat="identity", colour="blue", fill="blue") +
  facet_grid(. ~ City) +
  scale_x_discrete("year") +
  scale_y_continuous("CAGR since 1999", labels=percent) + 
  ggtitle("Compounded Annual Growth (Decrease) in emissions from motor vehicle sources")

grid.arrange(p1, p2)

ggsave(filename="Plot6.png")


s <- sqrt(1/(12*100))

n <- 1000

sqrt((n-1)*s^2/qchisq(c(0.975,0.5,0.025), n-1))

x <- runif(1000,0,1)
mean(x)


y <- runif(100,0,1)
sd(y)

x <- numeric()

for (i in 1:1000) {
  y <- runif(100,0,1)
  x <- c(x,sd(y))
}
mean(x)

x <- numeric()

for (i in 1:1000) {
  y <- runif(1000,0,1)
  x <- c(x,mean(y))
}
mean(x)
