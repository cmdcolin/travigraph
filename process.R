#!/usr/bin/env Rscript

library(jsonlite)
library(chron)
library(stringr)


# process input json dates and duration to minutes
args <- commandArgs(trailingOnly = TRUE)
if(length(args)<2) {
    stop("Usage: <program> <input.json> <output.csv>")
}

text=readLines(args[1])
results=fromJSON(text)
results=results[!is.na(results$started_at),]
times=str_split(results$started_at,"T")

process_date<-function(time) {
    chron(dates=time[[1]],times=str_sub(time[[2]],1,-2),
        format = c(dates = "y-m-d", times = "h:m:s"))
}
results$duration=results$duration/60
results$started_at=sapply(times,process_date)

#write to output csv
write.csv(results,file=args[2],row.names=F,quote=F)

