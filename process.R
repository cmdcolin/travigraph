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

x=readLines(f)
j=fromJSON(x)
#avoid rows with no starting time
j=j[!is.na(j$started_at),]
# scale duration
j$duration=j$duration/60
# process date/time strings with chron
ret=str_split(j$started_at,"T")


j$started_at=sapply(ret,function(ret) {
    chron(dates=ret[[1]],times=substr(ret[[2]],1,str_length(ret[[2]])-1),
        format = c(dates = "y-m-d", times = "h:m:s"))
})

# setup ggplot to read directly from the data frame
myplot<-ggplot(j,aes(started_at,duration,data), colour=state) +
    geom_point(aes(colour=state))+
    ggtitle("Travis-CI Builds") +
    xlab("Date") +
    ylab("Travis-CI build time (minutes)") +
    scale_x_chron(format="%D %H:%M") +
    expand_limits(y=0) +
    theme(axis.text.x = element_text(angle = 30, hjust = 1)) +
    scale_colour_manual(values=c("yellow","grey","red","green"))

png(args[1],width=1000,height=600)
myplot
dev.off()

