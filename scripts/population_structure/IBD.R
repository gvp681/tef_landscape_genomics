## Load R Packages
library(rdist)
library(fields)
library(dplyr)
library(reshape2)
library(vegan)
library(tidyr)
library(ggplot2)

## Load Data
data <- read.csv("tef_passport.csv")
group <- read.csv("COORD_bins.csv")
fst <- read.csv("fst_output.csv") 

## Structure and Combine Data
group$Sample <- sub("^([A-Z]\\d+).*", "\\1", group$ID)
group <- group[-c(1:2)]
group$bin <- as.factor(group$bin)

data_reduced <- data[-c(2:6,9:57)]
data_reduced$bin <- as.factor(data_reduced$bin)
data_reduced <- merge(data_reduced, group, by = "Sample")
data_reduced <- data_reduced[-1]
data_reduced <- data_reduced %>% distinct()

## Calculate distance matrice using coordinate groups
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
fst_df$fst <- ifelse(fst_df$fst < 0, 0, fst_df$fst) #Convert negative fst values to 0
merged_df <- merge(dist_df, fst_df, by = c("Var1", "Var2"), all = TRUE)

## Keep distinct rows based on unique combinations of Var1 and Var2
unique_merged_df <- merged_df[!duplicated(merged_df$fst), ]

## Plot
plot(prov$dist, prov$g_dist, pch=20, cex=0.5,xlab="Geographic Distance", ylab="Prevosti's Distance")
image(dens, col = transparentColors, add = TRUE)
abline(lm(prov$g_dist ~ prov$dist))
lines(loess.smooth(prov$dist, prov$g_dist), col="red")
#######NOT DONE###############

################ Mantel Tests ######################
## Create Pairwise Distance Matrices from Dataframes without Calculation (distances already calculated)
fst_matrix <- with(fst_df, fst)
nams <- with(fst_df, unique(c(as.character(Var1), as.character(Var2))))
attributes(fst_matrix) <- with(fst_df, list(Size = length(nams),
                                  Labels = nams,
                                  Diag = FALSE,
                                  Upper = FALSE,
                                  method = "user"))
class(fst_matrix) <- "matrix"

dist_matrix <- with(dist_df, dist)
nams <- with(dist_df, unique(c(as.character(Var1), as.character(Var2))))
attributes(dist_matrix) <- with(dist_df, list(Size = length(nams),
                                            Labels = nams,
                                            Diag = FALSE,
                                            Upper = FALSE,
                                            method = "user"))
class(dist_matrix) <- "matrix"

## IBD <- vegan::mantel(fst_matrix2,dist_matrix2, method="spear", permutations = 9999, na.rm = TRUE)
