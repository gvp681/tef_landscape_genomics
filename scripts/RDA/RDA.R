### Data analysis was based on the online tutorial material provided by ###
### https://bookdown.org/hhwagner1/LandGenCourse_book/WE_11.html ###
### https://popgen.nescent.org/2018-03-27_RDA_GEA.html  ###

### The following code outlines how we structured our data prior to following the direction of the online resources ###

## Load R Packages
library(data.table)
library(vegan)

## Load and Structure Data
options(datatable.fread.datatable=FALSE)
env <- read.csv("tef_passport.csv", row.names =1)
gen <- fread("plate_2_filtered2_quantile_numeric.csv") # VCF converted to numeric format
rownames(gen) <- gen$V1
gen <- gen[order(gen$V1),]
gen <- gen[-1]

## RDA requires complete data frames (i.e., no missing data). 
## We will impute using the most common genotype at each SNP across all individuals.
sum(is.na(gen)) #contains NAs
gen.imp <- apply(gen, 2, function(x) replace(x, is.na(x), as.numeric(names(which.max(table(x)))))) 
sum(is.na(gen.imp)) # No NAs

## Confirm that genotypes and environmental data are in the same order
identical(rownames(gen.imp), env[,1]) 

########### analysis ready #############
                 
### Post-testing for environmental factor multicollinearity (|r| > 0.7 ; VIF less than or equal to 5) and 
### formal testing for analysis of variance to assess the significance of both the full model and reduced models. 
### Each reduced model's statistical significance was evaluated using a permutation-based analysis of variance (ANOVA) 
### with 999 permutations and a significance level (α) of 0.05 model, subset data with model chosen variables.
pred <- subset(env, select = c("bio1","bio7","bio13","bio14","bio18","bio19")) 
