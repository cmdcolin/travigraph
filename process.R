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
q<-qplot(started_at,duration,data=j,color=factor(state))
q<-q+ggtitle("Travis-CI Builds")
q<-q+xlab("Date")
q<-q+ylab("Travis-CI time (minutes)")
q<-q+scale_x_chron(format="%D %H:%M")
q<-q+expand_limits(y=0)
q<-q+theme(axis.text.x = element_text(angle = 30, hjust = 1))

png(args[1])
q
dev.off()

