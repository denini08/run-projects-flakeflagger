#!/bin/bash

# ./run.sh hector 50 1 -> runs hector exp1 for 50 times
# ./run.sh hbase 8 2 -> runs hbase exp2 for 8 times
# ./run.sh ninja 3 2 -> runs ninja exp1 for 3 times

# results will be in the folder called `results

if [ ! $# -eq 3 ]
  then
      echo "Error with arguments supplied"
      echo "Usage: $> ./run.sh <project-name> <number-of-reruns> <exp-num> "
      echo "you can see the <project-name> in the file project-names.txt"
      echo "Example:"
      echo "./run.sh hector 50 1"
      exit 1
fi

name=$1
runs=$2
exp=$3

# fix permission denied docker
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

#create folder to logs
mkdir results
mkdir results/exp$exp


nohup docker run --rm -v ${PWD}/results/exp$exp/:/noise/RESULTS_flakeflagger denini/noise-instrumentation-flakeflagger-$name $runs $exp  &> exp$exp.log &

echo "running project $name, with exp$exp for $runs time(s)"
