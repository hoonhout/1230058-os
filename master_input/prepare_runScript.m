clear
RunDir='p:\1230058-os\swanmodel\TEST01\RUN_TEST7\';
DirDir=dir([RunDir 'D*']);

for uu=1:length(DirDir)
    WindDirOO(uu,:)=dir([RunDir DirDir(uu).name '\*OOa']);
    WindDirNZ(uu,:)=dir([RunDir DirDir(uu).name '\*NZa']);
end


fname=['submit_runs.sh'];
fsco = fopen(fname,'w+t');
fprintf(fsco,'%s\n','#!/bin/sh');
fprintf(fsco,'%s\n','queue=normal-e3');
fprintf(fsco,'%s\n','cp /p/1230058-os/swanmodel/TEST01/0prepare/shell_script/run .')
fprintf(fsco,'%s\n','cp /p/1230058-os/swanmodel/TEST01/0prepare/shell_script/swaninit .')
for d=1:size((WindDirNZ),1)
    for c=1:size((WindDirNZ),2)
        fprintf(fsco,'qsub -q $queue run %s\n',[WindDirNZ(d,c).name ' ' WindDirOO(d,c).name]);
    end
end
fclose(fsco)
unix2dos(fname,true)
