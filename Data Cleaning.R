# libraries
library(tidyverse)
# function paths
source("C:/Users/Siegfred Codia/Documents/Acads/MS Stat/Thesis/Data/download_NOAA v3.R")
source("C:/Users/Siegfred Codia/Documents/Acads/MS Stat/Thesis/Data/read_NOAA.R")

# Data paths
data.path <- "C:/Users/Siegfred Codia/Documents/Acads/MS Stat/Thesis/Data"
NOAA.path <- file.path(data.path,"NOAA/daily extracted")

## Admin boundaries ----
library(rgdal)
bound.path <- file.path(data.path, "Admin Boundaries")
bound.path
adm2 <- readOGR(dsn = file.path(bound.path, 
                                "Admin2-Province/phl_admbnda_adm2_psa_namria_20200529.shp"))
adm3 <- readOGR(dsn = file.path(bound.path, 
                                "Admin3-City/Polygon/phl_admbnda_adm3_psa_namria_20200529.shp"))
## Stations ----
stations <- read.csv(file.path(data.path,"NOAA/NOAA PH Weather Stations.csv"))

# downloading all available data

# I - ILOCOS ##################
laoag <- read_NOAA(station = 982230, start = 1981, end = 2020, 
                   path = NOAA.path, verbose = F)
sinait <- read_NOAA(station = 982220, start = 1981, end = 2020, 
                    path = NOAA.path, verbose = F)

dagupan <- read_NOAA(station = 983250, start = 1981, end = 2020, 
                     path = NOAA.path, verbose = F)

# CAR ####
baguio <- read_NOAA(station = 983280, start = 1981, end = 2020, 
                    path = NOAA.path, verbose = F)
baguio.max <- baguio%>% group_by(YEAR)%>% summarize(MAX.PRCP = max(PRCP, na.rm = T))
baguio.gevd <- EnvStats::egevd(baguio.max$MAX.PRCP)
baguio.gevd$parameters[1]
library(EnvStats)
library(extRemes)
ggplot(data = max.spread, aes(x = ILOILO))+
    geom_histogram(aes(y=..density..), bins = 20)+
    stat_function(fun = EnvStats::dgevd, args = list(location = iloilo.gevd$parameters[1], 
                                           scale = iloilo.gevd$parameters[2],
                                           shape = iloilo.gevd$parameters[3]))
baguio.gevd$parameters
qgevd(0.99,location = baguio.gevd$parameters[1], 
      scale = baguio.gevd$parameters[2],
      shape = baguio.gevd$parameters[3])

baguio.gevd2 <- fevd(baguio.max$MAX.PRCP, baguio.max)
return.level(baguio.gevd2)
View(max.spread)
fevd(subset(max.spread, LAOAG != -Inf)$LAOAG, subset(max.spread, LAOAG != -Inf))
iloilo.gevd <- egevd(subset(max.spread, ILOILO != -Inf)$ILOILO)

qgevd(0.98,location = egevd(max.spread$ZAMBOANGA)$parameters[1], 
      scale = egevd(max.spread$ZAMBOANGA)$parameters[2],
      shape = egevd(max.spread$ZAMBOANGA)$parameters[3])
egevd(max.spread$ZAMBOANGA)
View(max.spread)
# II - Cagayan
basco <- read_NOAA(station = 981340, start = 1981, end = 2020, 
                    path = NOAA.path, verbose = F)
itbayat <- read_NOAA(station = 981320, start = 1981, end = 2020, 
                   path = NOAA.path, verbose = F)
aparri <- read_NOAA(station = 982320, start = 1981, end = 2020, 
                   path = NOAA.path, verbose = F)
calayan <- read_NOAA(station = 981330, start = 1981, end = 2020, 
                   path = NOAA.path, verbose = F)
tuguegarao <- read_NOAA(station = 982330, start = 1981, end = 2020, 
                   path = NOAA.path, verbose = F)
# III 
casiguran <- read_NOAA(station = 983360, start = 1981, end = 2020, 
                       path = NOAA.path, verbose = F)
baler <- read_NOAA(station = 983340, start = 1981, end = 2020, 
                   path = NOAA.path, verbose = F)
View(baler)

# downloading all data
download_NOAA(stations$USAF.ID, WBAN = stations$WBAN, years = 1981:2020, dest.path =NOAA.path, 
    timeout = 60, overwrite = FALSE,verbose = TRUE)



# READING ALL DATA ############################
# initialize df
max.spread <- data.frame(YEAR = 1981:2020)

for (i in 1:nrow(stations)){
    stationname <- stations[i,"NOAA.Station"]
    usaf <- stations[i,"USAF.ID"]
    wban <- stations[i,"WBAN"]
    data <- read_NOAA(station = usaf, WBAN = wban, start = 1981, end = 2020, 
              path = NOAA.path, verbose = F)%>% 
        group_by(YEAR)%>%
        summarize(MAX.PRCP = max(PRCP, na.rm = T))
    
    max.data <- data.frame(data$MAX.PRCP)
    
    max.spread <- cbind(max.spread, max.data)
    print(paste(stationname,"done!"))
}
View(max.spread)    
colnames(max.spread)<- c("YEAR", stations[,"NOAA.Station"])
getwd()
write.csv(max.spread, "max.spread.csv")
cabanatuan <- read_NOAA(station = 983300, start = 1981, end = 2020, 
                        path = NOAA.path, verbose = F)
View(subset(cabanatuan, YEAR ==1994))


max.spread$LAOAG[max.spread$LAOAG!=-Inf]
EnvStats::egevd(max.spread$LAOAG[max.spread$LAOAG!=-Inf])

extRemes::fevd(max.spread$LAOAG[max.spread$LAOAG!=-Inf],data.frame(max.spread$LAOAG[max.spread$LAOAG!=-Inf]))
qnorm(0.5)
zamboanga <- read_NOAA(station = 988360, start = 1981, end = 2020, 
                          path = NOAA.path, verbose = F)
View(zamboanga)

dumaguete <- read_NOAA(station = 986420, start = 1986, end = 1986, 
                       path = NOAA.path, verbose = F)
View(dumaguete)

library(EnvStats)
# using cleaned data
fixed.max <- read.csv("max.spread.csv")
calayan.fixed <- subset(fixed.max, !is.na(Calayan))$Calayan
calayan.fixed.gevd <- egevd(calayan.fixed)

qgevd(0.98, 
      location = calayan.fixed.gevd$parameters[1],
      scale = calayan.fixed.gevd$parameters[2],
      shape = calayan.fixed.gevd$parameters[3])

ggplot(subset(fixed.max, !is.na(Calayan)), aes(x = Calayan))+
    geom_histogram(aes(y = ..density..), bins = 10)+
    stat_function(fun = EnvStats::dgevd, 
                  args = list(location = calayan.fixed.gevd$parameters[1], 
                              scale = calayan.fixed.gevd$parameters[2],
                              shape = calayan.fixed.gevd$parameters[3]), 
                  color = "red")

# using raw data from NOAA 
calayan.max <- calayan%>%group_by(YEAR)%>%summarise(MAX.PRCP = max(PRCP, na.rm = T))
calayan.gevd <- EnvStats::egevd(subset(calayan.max, MAX.PRCP != "-Inf")$MAX.PRCP)
View(calayan.max)
qgevd(0.98, 
      location = calayan.gevd$parameters[1],
      scale = calayan.gevd$parameters[2],
      shape = calayan.gevd$parameters[3])

ggplot(calayan.max, aes(x = MAX.PRCP))+
    geom_histogram(aes(y = ..density..), bins = 10)+
    stat_function(fun = EnvStats::dgevd, args = list(location = calayan.gevd$parameters[1], 
                                                     scale = calayan.gevd$parameters[2],
                                                     shape = calayan.gevd$parameters[3]), 
                  color = "red")

calayan.gevd$parameters
View(baguio)
