#!/bin/bash
if [ $# -ne 4 ]; then
    echo "usage: program <user/repo> <start build> <end build> <image.png>";
    exit 1;
fi
for i in `seq $2 25 $3`; do
    echo Processing build $i;
    travis raw --json /repos/$1/builds?after_number=$i |\
        Rscript remove_bad_json.R > $i.parsed.json;
done;

Rscript merge_json.R *parsed.json > out.json;
cat out.json | Rscript process.R $4
