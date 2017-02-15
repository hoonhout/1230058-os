clear all;
close all;
clc;

create_input=1; %set =1 to create input folders
file_name='p:\1230058-os\swanmodel\TEST01\0prepare\Offshore_boundaries\Offshore_conditions.xlsx';

run={'NZ' 'OO'};
%wind dir and wind speed (potential to Open Water)
D=xlsread(file_name,'Sheet2','A2:A9');  %D={'240' '270' '315'};
U=xlsread(file_name,'Sheet2','B2:B8');
alfa           = 0.0185;
Uow     = Upot2Uow_Charnock(U,alfa);
%water levels
wlev=xlsread(file_name,'Sheet2','G2:G30');  %wlev={'-2.0',   '4.0'   };%this should match with the L variable
L= {'m200' 'm175' 'm150' 'm125' 'm100' 'm075' 'm050' 'm025' 'm000' 'p025' 'p050' 'p075' 'p100' 'p125' 'p150' 'p175' 'p200' 'p225' 'p250' 'p275' 'p299' 'p300' 'p350' 'p400' 'p450' 'p500' 'p550' 'p600' 'p650'};

%interpolate/extrapolate wave conditions
winddir = xlsread(file_name,'Sheet1','A3:A56');
windspd = xlsread(file_name,'Sheet1','B3:B56');
hs = xlsread(file_name,'Sheet1','D3:D56');
tp = xlsread(file_name,'Sheet1','E3:E56');

f_hs=scatteredInterpolant(winddir,windspd,hs);
f_tp=scatteredInterpolant(winddir,windspd,tp);
%version
v={'a'}


c=1;
for u1=1:length(run)
    for u3=1:length(D)
        mkdir(['D' sprintf('%0.3d',round(D(u3)))]);
        for u2=1:length(U)
            if D(u3)>=45 && D(u3)<=157.5;
                Hs=0;
                Tp=0;
            else
                Hs=f_hs(D(u3),U(u2));
                Tp=f_tp(D(u3),U(u2));
            end
            for u4=1:length(L)
                folder(c).name=['U' num2str(U(u2)) 'D' sprintf('%0.3d',round(D(u3))) 'L' L{u4} run{u1} 'a'];
                if create_input==1;
                    if wlev(u4)>=0 && u1==3
                        disp('No directory needed');
                    else
                        mkdir(['D' sprintf('%0.3d',round(D(u3))) '\' folder(c).name]);
                    end
                    if u1==1
                        %read master input for this case
                        %create new input file based on master input
                        %change input file (replace string in file)
                        %save input file in correct folder
                        if D(u3)>=45 && D(u3)<=157.5;
                            fmaster=['master_NZ_nobound.SWN'];%Direction with no input boundary conditions from NZ because waves are poiting out fo the OS (decided with Caroline 1-Feb-2017)
                        else
                            fmaster=['master_NZ.SWN'];%All other directions run normal
                        end
                        fnew=['D' sprintf('%0.3d',round(D(u3))) '\' folder(c).name '\' folder(c).name '.SWN'];
                        replace_string_in_file(fmaster,fnew,'[U]',num2str(U(u2)));
                        replace_string_in_file(fnew,fnew,'[Uow]',num2str((Uow(u2)),'%5.2f'));
                        replace_string_in_file(fnew,fnew,'[D]',num2str(D(u3)));
             			replace_string_in_file(fnew,fnew,'[D_name]',sprintf('%0.3d',round(D(u3))));
                        replace_string_in_file(fnew,fnew,'[L]',L{u4});
                        replace_string_in_file(fnew,fnew,'[wlev]',num2str(wlev(u4)));
                        replace_string_in_file(fnew,fnew,'[Hs]',num2str((Hs),'%5.2f'));
                        replace_string_in_file(fnew,fnew,'[Tp]',num2str((Tp),'%5.2f'));
                        replace_string_in_file(fnew,fnew,'[name]',folder(c).name);
                        replace_string_in_file(fnew,fnew,'[v]',v{1});
                    elseif u1==2
                        if D(u3)>=45 && D(u3)<=157.5;
                            fmaster=['master_OD_nobound.SWN'];%Direction with no input boundary conditions from NZ because waves are poiting out fo the OS (decided with Caroline 1-Feb-2017)
                        else
                            fmaster=['master_OO.SWN'];%For all directions where input is transmitted via de OSK barrier
                        end
                        fnew=['D' sprintf('%0.3d',round(D(u3))) '\' folder(c).name '\' folder(c).name '.SWN'];
                        replace_string_in_file(fmaster,fnew,'[U]',num2str(U(u2)));
                        replace_string_in_file(fnew,fnew,'[Uow]',num2str((Uow(u2)),'%5.2f'));
                        replace_string_in_file(fnew,fnew,'[D]',num2str(D(u3)));
                        replace_string_in_file(fnew,fnew,'[D_name]',sprintf('%0.3d',round(D(u3))));
                        replace_string_in_file(fnew,fnew,'[L]',L{u4});
                        replace_string_in_file(fnew,fnew,'[wlev]',num2str(wlev(u4)));
                        replace_string_in_file(fnew,fnew,'[Hs]',num2str((Hs),'%5.2f'));
                        replace_string_in_file(fnew,fnew,'[Tp]',num2str((Tp),'%5.2f'));
                        replace_string_in_file(fnew,fnew,'[name]',folder(c).name);
                        replace_string_in_file(fnew,fnew,'[v]',v{1});
                        replace_string_in_file(fnew,fnew,'[gate]','Open');
                    elseif u1==3
                        if wlev(u4)>=0
                            fmaster=['master_OD.SWN'];%Based on A02 from Caroline
                            fnew=['D' sprintf('%0.3d',round(D(u3))) '\' folder(c).name '\' folder(c).name '.SWN'];
                            replace_string_in_file(fmaster,fnew,'[U]',num2str(U(u2)));
                            replace_string_in_file(fnew,fnew,'[Uow]',num2str((Uow(u2)),'%5.2f'));
                            replace_string_in_file(fnew,fnew,'[D]',num2str(D(u3)));
                            replace_string_in_file(fnew,fnew,'[D_name]',sprintf('%0.3d',round(D(u3))));
                            replace_string_in_file(fnew,fnew,'[L]',L{u4});
                            replace_string_in_file(fnew,fnew,'[wlev]',num2str(wlev(u4)));
                            replace_string_in_file(fnew,fnew,'[Hs]',num2str((Hs),'%5.2f'));
                            replace_string_in_file(fnew,fnew,'[Tp]',num2str((Tp),'%5.2f'));
                            replace_string_in_file(fnew,fnew,'[name]',folder(c).name);
                            replace_string_in_file(fnew,fnew,'[v]',v{1});
                            replace_string_in_file(fnew,fnew,'[gate]','Dicht');
                        else
                            disp(['This water level is not ran with closed gates: ' num2str(wlev(u4))]);
                        end
                    end
                    c=c+1;
                    clear fmaster fnew
                else
                    disp(['continue with the folder names..' num2str(c)]);
                    c=c+1;
                end
            end
        end
    end
end


return
%Create run script
create_runscript=1; %set =1 to create input folders
if create_runscript==1
    fname=['sh_all_runs.sh'];
    fsco = fopen(fname,'w+t');
    for c=1:length(folder)
        fprintf(fsco,'sh runswan4110.bat %s\n',folder(c).name);
    end
    fclose(fsco)
end

return
%Create diff plots
create_diff_plots=0;
if create_diff_plots==1;
    dout='p:\1220073-swannoordzee\testOS\matlab\diff_figures\'
    mkdir(dout);
    for i=1:length(folder)-1
        pldif(folder(i).name);
        print('-dpng', '-r350', [dout 'HsigA00-' folder(i).name])
        close all
    end
end

%Create diff plots2D
create_diff_plots2D=0;
if create_diff_plots2D==1;
    dout='p:\1220073-swannoordzee\testOS\matlab\diff_figures2D\'
    mkdir(dout);
    for i=1:length(folder)-1
        pldif2D(folder(i).name);
        print('-dpng', '-r350', [dout 'HsigA00-' folder(i).name])
        close all
    end
end

%Create Hsig plots
create_Hsig_plots=0;
if create_Hsig_plots==1;
    dout='p:\1220073-swannoordzee\testOS\matlab\Hsig_plots\'
    mkdir(dout);
    for i=1:length(folder)-1
        pl_Hsig(folder(i).name);
        print('-dpng', '-r350', [dout folder(i).name])
        close all
    end
end

%Create Current plots
create_Curr_plots=0;
if create_Curr_plots==1;
    dout='p:\1220073-swannoordzee\testOS\matlab\Curr_plots\'
    mkdir(dout);
    for i=1:length(folder)-1
        pl_Curr(folder(i).name,dout);
        close all
    end
end


