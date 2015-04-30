#!/usr/bin/env Rscript

if(!require(jsonlite,quietly=TRUE,warn.conflicts=FALSE)) print("Install jsonlite")

# only stdin
f <- file("stdin")
open(f)

x=readLines(f)
j=fromJSON(x)
j$builds=j$builds[,c(1:7,9:12)]
writeLines(toJSON(j))
