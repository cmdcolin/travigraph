#!/usr/bin/env Rscript

suppressMessages(suppressWarnings(require(jsonlite)))

# get imagename for output
args <- commandArgs(trailingOnly = TRUE)
if(length(args)<1) {
    stop("Usage: <program> 1.json 2.json ... (writes to stdout)")
}
jsonResults=do.call(rbind, lapply(args,function(i) {
    fromJSON(readLines(i))$builds[,c("duration","started_at","state")]
}))

writeLines(toJSON(jsonResults))


