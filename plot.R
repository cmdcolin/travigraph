#!/usr/bin/env Rscript


require(RColorBrewer)
require(ggplot2)
require(lubridate)
require(scales)


# get imagename for output
args <- commandArgs(trailingOnly = TRUE)
if(length(args)<2) {
    stop("Usage: Rscript plot.R <input.csv> <output.png> [<width> <height>]")
}

results=read.csv(args[1])
results=results[complete.cases(results),]
outfile=args[2]
width=as.numeric(args[3])
height=as.numeric(args[4])
repo=args[5]

if(is.na(width))width=1000
if(is.na(height))height=600

# lubridate and calcualte duration from started_at-finished_at
results[,2]=ymd_hms(results[,2])
results[,3]=ymd_hms(results[,3])
duration=as.numeric(seconds(results[,3]-results[,2]))/60
results=cbind(results,duration)
colnames(results)<-c('state','started_at','finished_at','duration')

myplot<-ggplot(results,aes(started_at,duration), colour=state) +
    geom_point(aes(colour=state))+
    ggtitle(paste(repo,"builds")) +
    xlab("Date") +
    ylab("Build time (minutes)") +
    scale_colour_brewer(type="seq", palette="Spectral") 

png(outfile,width=width,height=height)
myplot
dev.off()

