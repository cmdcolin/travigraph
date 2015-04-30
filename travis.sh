#!/bin/bash
for i in `seq 800 25 1275`; do
    echo Processing build $i;
    travis raw --json /repos/GMOD/Apollo/builds?after_number=$i > $i.txt;
    cat $i.txt | Rscript remove_bad_json.R > $i.parsed.txt;
done;

Rscript merge_json.R *parsed.txt > out.json;
cat out.json | Rscript process.R output.png
