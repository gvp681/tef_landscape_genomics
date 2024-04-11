## Load R Packages
library(rdist)
library(fields)
library(dplyr)

## Load Data
data <- read.csv("tef_passport.csv")
group <- read.csv("COORD_bins.csv")

## Combine Data
data <- merge(data, group, by = "Sample")

## Calculate Distance Matrices using Sample Coordinates
lat_long_geo <- rdist.earth(data[c(6:7)], miles = FALSE)
row.names(lat_long_geo) <- data$Sample
colnames(lat_long_geo) <- data$Sample





plot(prov$dist, prov$g_dist, pch=20, cex=0.5,xlab="Geographic Distance", ylab="Prevosti's Distance")
image(dens, col = transparentColors, add = TRUE)
abline(lm(prov$g_dist ~ prov$dist))
lines(loess.smooth(prov$dist, prov$g_dist), col="red")
#######NOT DONE###############
