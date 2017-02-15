clear
RunDir='p:\1230058-os\swanmodel\TEST01\RUN_TEST5\';
DirDir=dir([RunDir 'D*']);

for uu=1:length(DirDir)
    WindDirOO(uu,:)=dir([RunDir DirDir(uu).name '\*OOa']);
    WindDirNZ(uu,:)=dir([RunDir DirDir(uu).name '\*NZa']);
end


fname=['submit_runs.sh'];
fsco = fopen(fname,'w+t');
for d=1:size((WindDirNZ),1)
    for c=1:size((WindDirNZ),2)
        fprintf(fsco,'./runCASE %s\n',[WindDirNZ(d,c).name ' ' WindDirOO(d,c).name]);
    end
end
fclose(fsco)
