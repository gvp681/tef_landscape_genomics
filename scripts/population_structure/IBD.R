## Load R Packages
library(rdist)
library(fields)
library(dplyr)
library(reshape2)

## Load Data
data <- read.csv("tef_passport.csv")
group <- read.csv("COORD_bins.csv")
fst <- read.csv("fst_output.csv") #this will read in as a pairwise matrix

## Structure and Combine Data
group$Sample <- sub("^([A-Z]\\d+).*", "\\1", group$ID)
group <- group[-c(1:2)]
group$bin <- as.factor(group$bin)

data_reduced <- data[-c(2:6,9:57)]
data_reduced$bin <- as.factor(data_reduced$bin)
data_reduced <- merge(data_reduced, group, by = "Sample")
data_reduced <- data_reduced[-1]
data_reduced <- data_reduced %>% distinct()

## Calculate distance matrices using coordinate groups
lat_long_geo <- rdist.earth(data_reduced[c(1:2)], miles = FALSE)
row.names(lat_long_geo) <- data_reduced$bin
colnames(lat_long_geo) <- data_reduced$bin

## Create a function to melt a pairwise matrix into a data frame
melt_matrix <- function(mat, value_name) {
  melted <- melt(mat)
  colnames(melted) <- c("Var1", "Var2", value_name)
  melted$Var1 <- as.factor(melted$Var1)
  melted$Var2 <- as.factor(melted$Var2)
  melted
}

## Melt the matrices into data frames and merge
dist_df <- melt_matrix(lat_long_geo, "dist")
fst_df <- melt_matrix(fst, "fst")
merged_df <- merge(dist_df, fst_df, by = c("Var1", "Var2"), all = TRUE)

## Keep distinct rows based on unique combinations of Var1 and Var2
unique_merged_df <- merged_df[!duplicated(merged_df$fst), ]

## Plot
plot(prov$dist, prov$g_dist, pch=20, cex=0.5,xlab="Geographic Distance", ylab="Prevosti's Distance")
image(dens, col = transparentColors, add = TRUE)
abline(lm(prov$g_dist ~ prov$dist))
lines(loess.smooth(prov$dist, prov$g_dist), col="red")
#######NOT DONE###############
