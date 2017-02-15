#!/bin/sh
./upload.sh
queue=aws
qsub -q $queue runSWAN4110_up U50D315Lp550NZa U50D315Lp550OOa
qsub -q $queue runSWAN4110_up U50D315Lp600NZa U50D315Lp600OOa
qsub -q $queue runSWAN4110_up U50D315Lp650NZa U50D315Lp650OOa
