#!/bin/bash

# ./run.sh hector 1 50 -> runs hector exp1 for 50 times
# ./run.sh hbase 2 8 -> runs hbase exp2 for 8 times
# ./run.sh ninja 1 3 -> runs ninja exp1 for 3 times

# results will be in the folder called `results

if [ ! $# -eq 3 ]
  then
      echo "Error with arguments supplied"
      echo "Usage: $> ./run.sh <project-name> <exp-num> <number-of-reruns> "
      echo "you can see the <project-name> in the file project-names.txt"
      echo "Example:"
      echo "./run.sh hector 1 50"
      exit 1
fi

name=$1
exp=$2
runs=$3

# fix permission denied docker
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

#create folder to logs
mkdir results
mkdir results/exp$exp


nohup docker run --rm -v ${PWD}/results/exp$exp/:/noise/RESULTS_flakeflagger denini/noise-instrumentation-flakeflagger-$name $exp $runs &> exp$exp.log &

echo "running project $name, with exp$exp for $runs time(s)"