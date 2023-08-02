#!/usr/bin/env Rscript

library(ggplot2)
library(plyr)

pr12 <- read.csv("../../MatlabCode/experiments/PlotData/pr_data_a12.csv", header=F)
pr22 <- read.csv("../../MatlabCode/experiments/PlotData/pr_data_a22.csv", header=F)
pr32 <- read.csv("../../MatlabCode/experiments/PlotData/pr_data_a32.csv", header=F)
pr62 <- read.csv("../../MatlabCode/experiments/PlotData/pr_data_a62.csv", header=F)
pr82 <- read.csv("../../MatlabCode/experiments/PlotData/pr_data_a82.csv", header=F)

pr12$frac <- rep(0, 100)
pr22$frac <- rep(1/2, 100)
pr32$frac <- rep(1/3, 100)
pr62$frac <- rep(1/6, 100)
pr82$frac <- rep(1/8, 100)

pr <- rbind(pr12, pr22, pr32, pr62, pr82)
names(pr) <- c("alpha", "adv.frac")
pr$advfactor <- paste(round(pr$adv.frac * 100), "%", sep="")


pdf("alpha_histogram_per_advfraction.pdf")

ggplot(pr) + geom_histogram(aes(x=alpha, group=advfactor, fill=advfactor), bins=30, center=1) + facet_grid(advfactor~.) + geom_vline(aes(xintercept=.35), size=1, color="pink") + theme_bw() + guides(fill="none")


pr_means <- ddply(pr, .(advfactor), summarize, mean_alpha = mean(alpha), sd=sd(alpha))

pdf("average_alpha_per_advfraction.pdf")

ggplot(pr_means) + geom_col(aes(advfactor, mean_alpha, fill=advfactor)) + geom_errorbar(aes(advfactor, ymin=mean_alpha-sd, ymax=mean_alpha+sd), width=.2) + theme_bw() + guides(fill="none") + ylab("Average alpha") + xlab("Colluding Attackers")
