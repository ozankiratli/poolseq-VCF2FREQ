#!/bin/bash

file=$1
output=$2
cp $file tmp1
header=`head -n1 $file | sed 's/# //'`
nCols=`printf "$header" | wc -w`
for (( i=5 ; i <= $nCols ; i++ )) ; do
    printf "$header\n" > $output
    awk -v OFS='\t' -v col="$i" 'NR>=2 { split($col,a,","); af=( a[1] / ( a[1] + a[2] + a[3] + a[4] ) ); $col=af ; print }' tmp1 >> $output
    cp $output tmp1
done
rm tmp1

