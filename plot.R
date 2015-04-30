#!/usr/bin/env Rscript

library(ggplot2)
library(chron)

# get imagename for output
args <- commandArgs(trailingOnly = TRUE)
if(length(args)<2) {
    stop("Usage: <program> <input.csv> <output.png>")
}
results=read.csv(args[1])


# setup ggplot to read directly from the data frame
# note: change format to reduce ggranularity in time
myplot<-ggplot(results,aes(started_at,duration,data), colour=state) +
    geom_point(aes(colour=state))+
    ggtitle("Travis-CI Builds") +
    xlab("Date") +
    ylab("Travis-CI build time (minutes)") +
    scale_x_chron(format="%D %H:%M") +
    expand_limits(y=0) +
    theme(axis.text.x = element_text(angle = 30, hjust = 1))

png(args[2],width=1000,height=600)
myplot
dev.off()

