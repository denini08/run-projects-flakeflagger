#!/bin/bash

# ./hbase.sh 1 50 -> runs exp1 for 50 times
# ./hbase.sh 2 8 -> runs exp2 for 8 times
# ./hbase.sh 1 3 -> runs exp1 for 3 times

# results will be in the folder called `results

if [ ! $# -eq 2 ]
  then
      echo "Error with arguments supplied"
      echo "Usage: $> ./hbase.sh <exp-num> <number-of-reruns> "
      echo "Example:"
      echo "./habse.sh 1 50"
      exit 1
fi


exp=$1
runs=$2

# fix permission denied docker
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

#create folder to logs
mkdir results

#run each exp
if [ $exp -eq 1 ]
    then
    mkdir results/exp1
    nohup docker run --rm -v ${PWD}/results/exp1/:/noise/RESULTS_flakeflagger denini/noise-instrumentation-flakeflagger-hbase 1 $runs &> exp1.log &
    echo "running exp1 for $runs times"
fi

if [ $exp -eq 2 ]
    then
    mkdir results/exp2
    nohup docker run --rm -v ${PWD}/results/exp2/:/noise/RESULTS_flakeflagger denini/noise-instrumentation-flakeflagger-hbase 2 $runs &> exp2.log &
    echo "running exp2 for $runs times"
fi