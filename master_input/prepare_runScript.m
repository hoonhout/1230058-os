clear
RunDir='p:\1230058-os\swanmodel\TEST01\RUN_TEST8\';
DirDir=dir([RunDir 'D*']);

for uu=1:length(DirDir)
    WindDirOO(uu,:)=dir([RunDir DirDir(uu).name '\*OOa']);
    WindDirNZ(uu,:)=dir([RunDir DirDir(uu).name '\*NZa']);
end


fname=['submit_runsNZOO.sh'];
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

%% OD
clear
RunDir='p:\1230058-os\swanmodel\TEST01\RUN_TEST8\';
DirDir=dir([RunDir 'D*']);

for uu=1:length(DirDir)
    WindDirOD(uu,:)=dir([RunDir DirDir(uu).name '\*ODa']);
end


fname=['submit_runsOD.sh'];
fsco = fopen(fname,'w+t');
fprintf(fsco,'%s\n','#!/bin/sh');
fprintf(fsco,'%s\n','queue=normal-e3');
fprintf(fsco,'%s\n','cp /p/1230058-os/swanmodel/TEST01/0prepare/shell_script/run_OD .')
fprintf(fsco,'%s\n','cp /p/1230058-os/swanmodel/TEST01/0prepare/shell_script/swaninit .')
for d=1:size((WindDirOD),1)
    for c=1:size((WindDirOD),2)
        fprintf(fsco,'qsub -q $queue run_OD %s\n',[WindDirOD(d,c).name]);
    end
end
fclose(fsco)
unix2dos(fname,true)
