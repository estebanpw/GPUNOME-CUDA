#!/bin/bash

QUERY=$1
REF=$2
DEV=$3
DIFF=$4
OVERLAP=$5
DIM=$6

if [ $# != 6 ]; then
	echo "***ERROR*** Use: $0 query ref device diff overlap dimension"
	exit -1
fi

BINDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

for ((i=16 ; i < 1025 ; i+=16))
do

#    for j in `seq 2 10`;
#    do
#        (time $BINDIR/run.sh $QUERY $REF $DEV $DIFF $OVERLAP $DIM $j $i) &> log_${DEV}_${DIFF}_${OVERLAP}_${DIM}_${j}_${i}
#    done

    for ((j=16 ; j < 1025 ; j+=16))
	do
        (time $BINDIR/run.sh $QUERY $REF $DEV $DIFF $OVERLAP $DIM $j $i) &> log_${DEV}_${DIFF}_${OVERLAP}_${DIM}_${j}_${i}

    done


done


