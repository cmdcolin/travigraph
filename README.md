Travigraph
==========

This program uses the command line tools for Travis-CI to download the build statistics on a given project
and then it graphs the results using R and ggplot2.

The code is made of several modules

1. travigraph - A command line runner that downloads "pages" of builds in JSON format
2. regularize_json - An R script for regularizing some data from the returned JSON
3. merge_json - Custom code to merge dataframes
4. process - Rendering JSON results with ggplot2


Pre-requisites
=============

- travis command line tool (`gem install travis`)
- R packages ggplot2, chron, stringr, jsonlite

Note: the travis command line tool should be authenticated to your account first too



Usage
====

    travigraph -r username/repo -b 50 -e 1000 -o output.png -cached

Note: the starting build -b seems to not return enough results at low values, so it is best to use a larger value such
as -b 50 to begin paginating.
