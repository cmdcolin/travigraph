Travis-CI grapher
==========

This program uses the command line tool for Travis-CI to download the build durations on a given project
and then graphs the results using R.

There are probably additional things that could be added as parameters but you may find the code simple enough to modify
yourself.

The code is made of several modules
1) A command line runner that downloads "pages" of builds in JSON format (25 at a time)
2) An R script for regularizing some data from the returned JSON
3) Custom code to merge dataframes
4) Rendering JSON results with ggplot2


Pre-requisites
=============

The travis command line tool (`gem install travis`). You need to authenticate it first, usually with a github token.
Several R packages (ggplot2, chron, stringr, jsonlite)
