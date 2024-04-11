## Load R packages
library(vcfR)
library(reshape2)
library(ggplot2)
library(adegenet)
library(RColorBrewer)
library(rnaturalearth)
library(rnaturalearthhires)
library(sf)
library(dplyr)

## Load Data
vcf <- read.vcfR("tef_accessions.vcf")

## Convert Genetic Data to Genlight Object
gl_rubi <- vcfRgenlight(vcf)

## K-means Clustering
#### Individual genetic ancestries were estimated using the Q matrix to determine the appropriate number of genetic clusters (K) through cross-validation. 
maxK <- 10
myMat <- matrix(nrow=10, ncol=maxK)
colnames(myMat) <- 1:ncol(myMat)
for(i in 1:nrow(myMat)){
  grp <- find.clusters(gl_rubi, n.pca = 40, choose.n.clust = FALSE,  max.n.clust = maxK)
  myMat[i,] <- grp$Kstat
}

## Visualize K-means Clustering
my_d <- melt(myMat)
colnames(my_df)[1:3] <- c("Group", "K", "BIC")
my_df$K <- as.factor(my_df$K)
head(my_df)
pdf("Kmeans_clusters.pdf")
p1 <- ggplot(my_df, aes(x = K, y = BIC))
p1 <- p1 + geom_boxplot()
p1 <- p1 + theme_bw()
p1 <- p1 + xlab("Number of groups (K)")
p1
dev.off()

## Discriminant Analysis of Principal Components
my_k <- 2:5
grp_l <- vector(mode = "list", length = length(my_k))
dapc_l <- vector(mode = "list", length = length(my_k))
for(i in 1:length(dapc_l)){
  set.seed(9)
  grp_l[[i]] <- find.clusters(gl_rubi, n.pca = 40, n.clust = my_k[i])
  dapc_l[[i]] <- dapc(gl_rubi, pop = grp_l[[i]]$grp, n.pca = 40, n.da = my_k[i])} ## this can be computationally intensive depending on max number of K and number of markers/individuals

tmp <- as.data.frame(dapc_l[[1]]$posterior) ## replace number with optimal K
tmp$K <- my_k[1] ## replace number with optimal K
tmp$Isolate <- rownames(tmp)
tmp <- melt(tmp, id = c("Isolate", "K"))
names(tmp)[3:4] <- c("Group", "Posterior")

## Visualize Individual Clusters on DAPC Axes: PC1 and PC2
pdf("DAPC_Clusters.pdf")
my_pal <- RColorBrewer::brewer.pal(n=8, name = "Dark2")

p2 <- ggplot(tmp, aes(x = LD1, y = LD2, color = Group, fill = Group))
p2 <- p2 + geom_point(size = 4, shape = 21)
p2 <- p2 + theme_bw()
p2 <- p2 + scale_color_manual(values=c(my_pal))
p2 <- p2 + scale_fill_manual(values=c(paste(my_pal, "66", sep = "")))
p2
dev.off()

## Load Passport Data
data <- read.csv("tef_passport.csv")

## Combine K-means Group Assignments with Passport Data
colnames(tmp$Isolate) <- "Sample"
tmp$Sample <- sub("^([A-Z]\\d+).*", "\\1", tmp$Sample)
data <- merge(data,tmp, by = "Sample")
data$Group <- as.factor(data$Group)

## Map K-means Group Assignments on Projection of Sampling Locations
et <- ne_states(country = "ethiopia", returnclass = "sf")
pdf("DAPC_Map.pdf")
ggplot() + geom_sf(data=et,aes(fill=name),color=NA) + theme_minimal() + 
  geom_point(data = data, aes(x= Longitude, y = Latitude, color = Group), size = 2,shape=23,fill = "black", stroke = 2) + 
  labs(title = "Geographic Distribution of Accessions Collected in Ethiopia", fill = "Region", color = "Group") + 
  scale_color_brewer(palette = "Dark2") + scale_fill_grey(start =0.8,end=0.05, guide = guide_none()) 
dev.off()
