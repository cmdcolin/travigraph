#!/usr/bin/env Rscript

if(!require(jsonlite,quietly=TRUE,warn.conflicts=FALSE)) print("Install jsonlite")
if(!require(ggplot2,quietly=TRUE)) print("Install ggplot2")
if(!require(chron,quietly=TRUE)) print("Install chron")
if(!require(stringr,quietly=TRUE)) print("Install stringr")


# get imagename for output
args <- commandArgs(trailingOnly = TRUE)
if(length(args)<1) {
    stop("Usage: <program> <output graph> (input from stdin)")
}
f <- file("stdin")
open(f)

text=readLines(f)
results=fromJSON(text)
results=results[!is.na(results$started_at),]
times=str_split(results$started_at,"T")

process_data<-function(time) {
    chron(dates=time[[1]],times=str_sub(time[[2]],end=-1),
        format = c(dates = "y-m-d", times = "h:m:s"))
}
results$duration=results$duration/60
results$started_at=sapply(times,process_date)

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

png(args[1],width=1000,height=600)
myplot
dev.off()

