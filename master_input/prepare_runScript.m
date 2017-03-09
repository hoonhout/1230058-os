%choose in line 16, 17, 18 the proper runs for NZ & OO   !!!!!!!!!!!!
%choose in line 41, 42, 43 the proper runs for OD   !!!!!!!!!!!!!!!!!
clear 
close all
clc

%        1      2      3      4      5      6      7      8      9      10     11     12     13     14     15     16     17     18     19     20     21     22     23     24     25     26     27  
widir={'023' ,'045', '068', '090', '113', '135', '158', '180', '203', '225', '248', '270', '293', '315', '338', '360'};
wispd={'10'  ,'20' , '24' ,'30', '28' , '34' , '38' , '42' , '46' , '50'};
walev={'m200','m175' 'm150' 'm125' 'm100' 'm075' 'm050' 'm025' 'm000' 'p025' 'p050' 'p075' 'p100' 'p125' 'p150' 'p175' 'p200' 'p225' 'p250' 'p275' 'p299' 'p300' 'p350' 'p400' 'p450' 'p500' 'p550' 'p600' 'p650'};
%NB: OO for dirs 22.5 up and including 180 the max windspeed is 38!!!

fname=['submit_runsNZOO.sh'];
fsco = fopen(fname,'w+t');
fprintf(fsco,'%s\n','#!/bin/sh');
fprintf(fsco,'%s\n','queue=normal-e3');
fprintf(fsco,'%s\n','cp /p/11200556-os/golven/SWAN01/SCRIPTS/shell_script/run .')
fprintf(fsco,'%s\n','cp /p/11200556-os/golven/SWAN01/SCRIPTS/shell_script/swaninit .')
for iwidir=[10] 
    for iwispd=[8:10] %[1:length(wispd)]
		for iwalev=[1:length(walev)]
			fprintf(fsco,'qsub -q $queue run %s\n',['U' wispd{iwispd} 'D' widir{iwidir} 'L' walev{iwalev} 'NZa U' wispd{iwispd} 'D' widir{iwidir} 'L' walev{iwalev} 'OOa']);
		end
	end
end
fclose(fsco)
unix2dos(fname,true)
clear fname fsco

return %!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
%% OD
%        1      2      3      4      5      6      7      8      9      10     11     12     13     14     15     16     17     18     19     20     21     22     23     24     25     26     27  
widir={'023' ,'045', '068', '090', '113', '135', '158', '180', '203', '225', '248', '270', '293', '315', '338', '360'};
wispd={'10'  ,'20' , '24' , '28' ,'30', '34' , '38' , '42' , '46' , '50'};
walev={'m200','m175' 'm150' 'm125' 'm100' 'm075' 'm050' 'm025' 'm000' 'p025' 'p050' 'p075' 'p100' 'p125' 'p150' 'p175' 'p200' 'p225' 'p250' 'p275' 'p299' 'p300' 'p350' 'p400' 'p450' 'p500' 'p550' 'p600' 'p650'};
%NB: OD only for >=NAP+0 m AND 203, 225, ...337.5, 360!!!!

fname=['submit_runsOD.sh'];
fsco = fopen(fname,'w+t');
fprintf(fsco,'%s\n','#!/bin/sh');
fprintf(fsco,'%s\n','queue=normal-e3');
fprintf(fsco,'%s\n','cp /p/11200556-os/golven/SWAN01/SCRIPTS/shell_script/run_OD .')
fprintf(fsco,'%s\n','cp /p/11200556-os/golven/SWAN01/SCRIPTS/shell_script/swaninit .')

for iwidir=[9] 
    for iwispd=[1:length(wispd)];
		for iwalev=[9:length(walev)]
			fprintf(fsco,'qsub -q $queue run_OD %s\n',['U' wispd{iwispd} 'D' widir{iwidir} 'L' walev{iwalev} 'ODa']);
		end
	end
end

fclose(fsco)
unix2dos(fname,true)
