#!/usr/bin/env Rscript

if(!require(jsonlite,quietly=TRUE,warn.conflicts=FALSE)) print("Install jsonlite")


# get imagename for output
args <- commandArgs(trailingOnly = TRUE)
if(length(args)<1) {
    stop("Usage: <program> <input_files> (extra input from stdin) (writes to stdout)")
}
jsonResults=do.call(rbind, lapply(args,function(i) {
    fromJSON(readLines(i))$builds[,c("duration","started_at","state")]
}))

writeLines(toJSON(jsonResults))


