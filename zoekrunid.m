runidlist=[];
mainpath='p:\1230058-os\swanmodel\TEST01\RUN_TEST5\';
cd(mainpath);
d1=dir('D*');
for i1=1:length(d1);
	cd(d1(i1).name);
	d2=dir('U*O*');
	for i2=1:length(d2);
		cd(d2(i2).name);
		d3=dir('*.PRT');
		if ~isempty(d3);
			runidname=d3.name(1:14);
			runidlist=[runidlist; runidname];
		end
		cd ..
	end
	cd ..
end
cd ../0prepare/