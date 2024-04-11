## Load R Packages
library(rdist)
library(fields)

## Load Data
data <- read.csv("tef_passport.csv")

## Calculate Distance Matrices using Sample Coordinates
lat_long_geo <- rdist.earth(data[c(6:7)], miles = FALSE)
row.names(lat_long_geo) <- data$Sample
colnames(lat_long_geo) <- data$Sample

#######NOT DONE###############
