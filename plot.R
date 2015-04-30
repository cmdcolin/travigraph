#!/usr/bin/env Rscript

library(ggplot2)
library(chron)

# get imagename for output
args <- commandArgs(trailingOnly = TRUE)
if(length(args)<2) {
    stop("Usage: <program> <input.csv> <output.png> [<width> <height>]")
}

results=read.csv(args[1])
outfile=args[2]
width=as.numeric(args[3])
height=as.numeric(args[4])

if(is.na(width))width=1000
if(is.na(height))height=600


# setup ggplot to read directly from the data frame
# note: change format to reduce ggranularity in time
myplot<-ggplot(results,aes(started_at,duration,data), colour=state) +
    geom_point(aes(colour=state))+
    ggtitle("Travis-CI Builds") +
    xlab("Date") +
    ylab("Build time (minutes)") +
    scale_x_chron(format="%D %H:%M") +
    expand_limits(y=0) +
    theme(axis.text.x = element_text(angle = 30, hjust = 1))

png(outfile,width=width,height=height)
myplot
dev.off()

