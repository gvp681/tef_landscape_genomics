### TO RUN: "Rscript FILTER_PARAMETER_FIGURE_CHECK_4.r"

library(data.table)
library(list)
library(ggplot2)
library(stringr)

traits <- c("depth")
#"depth","FS",and "MQ"
# QD and SOR done by hand in RStudio on local computer

for (i in traits)
{title <- fread(paste(i,".txt", sep=""))
print(title)
names(title) <- paste(i)
print(title)
print(class(title))
pdf(paste(i,"_2f2.pdf", sep=""))
}

ggplot(title,aes(x=depth)) + geom_density()
dev.off()

traits <- c("FS")

for (i in traits)
{title <- fread(paste(i,".txt", sep=""))
print(title)
names(title) <- paste(i)
print(title)
print(class(title))
pdf(paste(i,"_2f2.pdf", sep=""))
}

ggplot(title,aes(x=FS)) + geom_density()
dev.off()

traits <- c("MQ")

for (i in traits)
{title <- fread(paste(i,".txt", sep=""))
print(title)   
names(title) <- paste(i)
print(title)   
print(class(title))
pdf(paste(i,"_2f2.pdf", sep=""))
}

ggplot(title,aes(x=MQ)) + geom_density()
dev.off()

traits <- c("QD")

for (i in traits)
{title <- fread(paste(i,".txt", sep=""))
print(title)
names(title) <- paste(i)
print(title)
title$QD <- as.numeric(title$QD)
pdf(paste(i,"_2f2.pdf", sep=""))
}

ggplot(title,aes(x=QD)) + geom_density()
dev.off()

