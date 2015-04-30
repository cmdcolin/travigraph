Travigraph
==========

This program uses the command line tools for Travis-CI to download the build statistics on a given project
and then it graphs the results using R and ggplot2.

The code is made of several modules
1) A command line runner that downloads "pages" of builds in JSON format (25 at a time)
2) An R script for regularizing some data from the returned JSON
3) Custom code to merge dataframes
4) Rendering JSON results with ggplot2


Pre-requisites
=============

The travis command line tool (`gem install travis`)
Several R packages (ggplot2, chron, stringr, jsonlite)

Note: the travis command line tool should be authenticated to your account first too



Usage
====

Takes a username/repo (no .git extension) for a range of build numbers:

travigraph -r username/repo -b 0 -e 1000 -o output.png -cached
