clear all; close all; clc;

file_name='p:\1230058-os\swanmodel\TEST01\0prepare\Offshore_boundaries\Offshore_conditions.xlsx';
winddir = xlsread(file_name,'Sheet1','A3:A56');
windspd = xlsread(file_name,'Sheet1','B3:B56');
hs = xlsread(file_name,'Sheet1','D3:D56');
tp = xlsread(file_name,'Sheet1','E3:E56');

welkeWD=[202.5 225 247.5 270 292.5 315 337.5 360]'; %22.5 45 67.5 180
wind_speeds=[10 20 24 28 30 34 38 42 46 50]';

f_hs=scatteredInterpolant(winddir,windspd,hs);
f_tp=scatteredInterpolant(winddir,windspd,tp);

count=1;
for i=1:length(wind_speeds)
    for u=1:length(welkeWD)
        Wind_dir_swan(count)=welkeWD(u);
        Wind_speed_swan(count)=wind_speeds(i);
        Hs_swan(count)=f_hs(welkeWD(u),wind_speeds(i));
        Tp_swan(count)=f_tp(welkeWD(u),wind_speeds(i));
        count=count+1;
    end
end

offshore_conditions =[Wind_speed_swan;Wind_dir_swan;Hs_swan;Tp_swan]';


return

%old method

for a=1:length(wind_speeds)
    welkeWS=repmat(wind_speeds(a),length(welkeWD),1)
    [WDq,WSq,HSq]=griddata(winddir,windspd,hs,welkeWD,welkeWS,'v4');
    [WDq,WSq,TPq]=griddata(winddir,windspd,tp,welkeWD,welkeWS,'v4');
    
    [WDq,WSq,HSq_linear]=griddata(winddir,windspd,hs,welkeWD,welkeWS,'linear');
    [WDq,WSq,TPq_linear]=griddata(winddir,windspd,tp,welkeWD,welkeWS,'linear');
    
    format bank
    [WDq,WSq,HSq,HSq_linear,TPq,TPq_linear]
end