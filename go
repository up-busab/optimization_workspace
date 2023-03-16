#!/bin/bash
target=`cat hax/target`
version=`cat hax/version`

if [ "$1" = "sa" ]
then
    tech="java8"
else
    if [ "$1" = "mip" ]
    then
        tech="gurobi"
    else
        if [ "$1" = "viz" ]
        then
            tech="vapory"
        else
            echo "Usage: ./go mip OR ./go sa"
            exit -1
        fi
    fi
fi

./hax/build instance$version $target
./hax/run $version $target $tech
