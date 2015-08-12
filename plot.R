#!/usr/bin/env Rscript

require(ggplot2)
require(lubridate)
require(scales)


# get imagename for output
args <- commandArgs(trailingOnly = TRUE)
if(length(args)<2) {
    stop("Usage: Rscript plot.R <input.csv> <output.png> [<width> <height>]")
}

results=read.table(args[1])
results=results[complete.cases(results),]
outfile=args[2]
width=as.numeric(args[3])
height=as.numeric(args[4])

if(is.na(width))width=1000
if(is.na(height))height=600


results[,2]=ymd_hms(results[,2])
results[,3]=ymd_hms(results[,3])
duration=seconds(results[,3]-results[,2])
results=cbind(results,duration)
colnames(results)<-c('state','started_at','finished_at','duration')

print(results)


# setup ggplot to read directly from the data frame
# note: change format to reduce ggranularity in time
myplot<-ggplot(results,aes(started_at,duration), colour=state) +
    geom_point(aes(colour=state))+
    ggtitle("Travis-CI Builds") +
    xlab("Date") +
    ylab("Build time (minutes)") +
    expand_limits(y=0) +
    theme(axis.text.x = element_text(angle = 30, hjust = 1)) + 
    scale_x_date(labels = date_format("%b"))

png(outfile,width=width,height=height)
myplot
dev.off()

