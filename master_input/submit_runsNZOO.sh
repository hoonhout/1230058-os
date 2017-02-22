#!/bin/sh
queue=normal-e3
cp /p/1230058-os/swanmodel/TEST01/0prepare/shell_script/run .
cp /p/1230058-os/swanmodel/TEST01/0prepare/shell_script/swaninit .
qsub -q $queue run U10D203Lm000NZa U10D203Lm000OOa
qsub -q $queue run U10D203Lm100NZa U10D203Lm100OOa
qsub -q $queue run U10D203Lm200NZa U10D203Lm200OOa
qsub -q $queue run U10D203Lp100NZa U10D203Lp100OOa
qsub -q $queue run U10D203Lp200NZa U10D203Lp200OOa
qsub -q $queue run U10D203Lp300NZa U10D203Lp300OOa
qsub -q $queue run U10D203Lp400NZa U10D203Lp400OOa
qsub -q $queue run U10D203Lp650NZa U10D203Lp650OOa
