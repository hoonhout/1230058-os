#!/bin/sh
queue=normal-e3
cp /p/1230058-os/swanmodel/TEST01/0prepare/shell_script/run_OD .
cp /p/1230058-os/swanmodel/TEST01/0prepare/shell_script/swaninit .
qsub -q $queue run_OD U10D203Lm000ODa
qsub -q $queue run_OD U10D203Lp100ODa
qsub -q $queue run_OD U10D203Lp200ODa
qsub -q $queue run_OD U10D203Lp300ODa
qsub -q $queue run_OD U10D203Lp400ODa
qsub -q $queue run_OD U10D203Lp650ODa
