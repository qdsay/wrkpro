#!/bin/bash

c=1
t=1
d="1s"
s=""

while getopts ":c:t:d:s:" opt
    do
    case "$opt" in
        "c")
            c=$OPTARG
        ;;
        "t")
            s=$OPTARG
        ;;
        "d")
            d=$OPTARG
        ;;
        "s")
            s=$OPTARG
        ;;
        "?")
            echo "Unknown option $OPTARG"
        ;;
        ":")
            echo "No argument value for option $OPTARG"
        ;;
        *)
          # Should not occur
            echo "Unknown error while processing options"
        ;;
    esac
done

while read line; do
    echo "wrk -c $c -t $t -d $d -s $s --latency http://$line"
    wrk -c $c -t $t -d $d -s $s --latency http://$line > log/$line.log 2>&1 &
done < hosts.txt
