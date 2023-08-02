#!/usr/bin/env Rscript
library("reshape2")
library("plyr")
library("ggplot2")

nid <- read.csv("nodeIDs.csv", header=F, na.strings="0")
rid <- read.csv("randomIDs.csv", header=F, na.strings="0")
tid <- read.csv("targetIDs.csv", header=F, na.strings="0")
ubid <- read.csv("upperboundsIDs.csv", header=F, na.strings="0")

names(nid) <- c("reqid", paste("V",1:99, sep=""))
rid$V100 <- NULL
tid$V100 <- NULL
ubid$V100 <- NULL

nid$run <- rownames(nid)
rid$run <- rownames(rid)
tid$run <- rownames(tid)
ubid$run <- rownames(ubid)

dat <- cbind(melt(nid, id=c("run", "reqid"), variable.name="hop", value.name="nid"),
             rid=melt(rid, id="run",  value.name="rid")$rid,
             tid=melt(tid, id="run",  value.name="tid")$tid,
             ubid=melt(ubid, id="run", value.name="ubid")$ubid)

dat$run <- as.numeric(dat$run)
dat$hop <- as.numeric(dat$hop)

dat.trim <- dat[!is.na(dat$rid),]

dat.norm <- adply(dat.trim, 1, summarize,
                  r=(rid+2^23-nid) %% 2^23,
                  o=(tid+2^23-nid) %% 2^23,
                  ub=(ubid+2^23-nid) %% 2^23)[c("run", "hop", "reqid", "r", "o", "ub")]


ggplot(dat.norm) + geom_histogram(aes(o*100/ub), binwidth=2, color="white") + theme_bw()
