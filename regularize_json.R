#!/usr/bin/env Rscript

library(jsonlite)

# only stdin
f <- file("stdin")
open(f)

x=readLines(f)
j=fromJSON(x)
j$builds=j$builds[,c(1:7,9:12)]
writeLines(toJSON(j))
