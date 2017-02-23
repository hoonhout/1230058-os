22 Feb
-Fix OD transmission script (it creates the folder name based on OO not OD
-Ask Bas how to update the SCRIPTS dir (sync/commit/push/pull)
-Ask Jamie to update the checkbulk.py script to say 240 min limit ?

21 Feb
- Run take longer to Run in Amazon. The checkbulk scirpt says all 50 runs took more than 180 minutes to run in total (even for the NZ grid???). 
- For now it was decided to keep all the output figures and files and just copy them to the P drive. At a later stage it might be needed to create a visualizer to see figure directly on Amazon.

20 feb
- CG: vraag joost den bieman in hoeverre bijv figuur 'p:\1230058-os\swanmodel\TEST01\CONTROL\consistencywind\D338Lp650OOa_hs.png' consistent is met fig 4.2 en appendix C.7 ofzo  uit zijn OS rapportage
- Decided to increase the number of iterations for OS from 60 to 80, after checking the convergence plots and the computational time (bulk script) (ASK Caroline after meeting with Alfons 21Feb)
			DEcided to change to 80 it and 101% convergence (after meeting with Alfons)
- Jamie to update scripts to read OO and OD (when necessary to specify the region) {remember to submit updated scripts to the script directory} --> DONE JM
- SOURCE PY:
	source /opt/python/pythonsource.sh
	source /p/1230058-os/virtualenvs/oosterschelde/bin/activate
- RUN: checkbulk.py
		python checkbulk.py /p/1230058-os/swanmodel/TEST01/RUN_TEST7/D293 /p/1230058-os/swanmodel/TEST01/CONTROL 'OS'
		python checkbulk.py /p/1230058-os/swanmodel/TEST01/RUN_TEST7/D293 /p/1230058-os/swanmodel/TEST01/CONTROL 'NZ'
		
-  Updated scripts have to be pulled to the SCRIPTS directory (plmaps IKDENKZO from Caroline and plspectra from Jamie, etc)  -->DONE AC

-Update the run script to include the new scripts (plmaps for NZ $1 and for OS $2) ---> DONE AC


17 feb
-write up the steps to build the runs (wind fields, master_input files, closed open cases, submit scripts, python scripts, Amazon, transmission, installation in the H6, repository, etc...)
-finshed updating the scripts (convergence, spectra) -->DONE JM
-Still have to prepare the closed runs script (decide which post-processing is needed, etc)

16 feb
-Remember to update the repository with the new scripts -->DONE AC
-change the run script to read scripts from repository not 0prepare ---> DONE AC

15 feb:
-Dont forget to do dos2unix with the submit script otherwise the folder names are not found!
-pip install netCDF4 (on the h6)
-update all scripts for figure properties on the H6  --->C based settings
-plmaps only for OS? why does it take so long to run? FIXED
-make a script (later) telling us which runs are finished or still need to be done --> FIXED Caroline did it (Proc checks \ watisklaar.m)


14 feb: 

- to be done run_test5: 3 directions, 3 speeds, 4 water levels --> DONE
  including postprocessing scripts  __> SUBMITTED 14-FEB-2017 (including plspectra.py + plconvergence.py)

- DO NOT FORGET TO USE THE PROPER (OFFICIAL) SWAN EXECUTABLE FROM HUIB TANIS ONCE IT IS READY ---> How will I know when this is realeased? Ask Caroline 14-Feb-2017

- test the python wave transmission script by making the test plots (like A.3.4 in the swan report)

-Spectra plot only made for NZ (ask Jamie to check script)
-plmaps.py cant read from netCDF4 import Dataset (ask Bas what to add to the H6 environment) --->pip install netCDF4 (on the h6)

===================================================================================
README RUN_TEST

RUN_TEST initial input files (no wind fields, testing the submit scripts individually)
RUN_TEST2 testing a series of runs being submitted to Amazon and H6 (include wind fields)
RUN_TEST3 more complete runs for different WL + Dir + Wind Speed with submit script to H6
RUN_TEST4 save computational time, run more cases from the same direction (problem with no spectra for the low water levels solved)
RUN_TEST5 testing python scripts, still not fully working, good results for testing of the scripts
RUN_TEST6 submit the same way the runs are submitted for Amazon, testing goes well, extra editing of the python scripts to work for different types of possible results
RUN_TEST6_2it testing runs with 2 iterations to check the python post-processing scripts
RUN_TEST7 running in H6 and in Amazon (running D293 with a combination of Wind Speeds and Water levels, all python scripts should work, results will be ready before Monday 20th on the H6)

===================================================================================

------------------------------------------------------------------------------

- D023 instead of D23 etc in the directory names and everywhere (also within *.SWN) ---> FIXED
- WCAP KOMEN ...  --->FIXED
- OD in the upper lines in *.SWN state 'Dicht' --->FIXED
- U20D315 to be checked in INPVAR/RVW   --->FILES ARE BEING PRINTED, CHECK WITH BAS TO SEE IF HE REMOVED THEM EARLIER FOR SOME REASON.

-----------------------------------------------------------------------------
7 feb cg:
amaury will make two runscripts (to be used for all 'western' directions):
	1. NZ - transmissionOO - OO (open)
	2.      transmissionOD - OD (closed)	(due to overtopping)
	'2' can only start after NZ is finished
	
for the eastern directions we also run NZ, but the OO files will have no boundary conditions specified (so based on another master file). Those directions will be run with the '1' script (see above). 
There is no OD from the east. East is defined as 45 up and including 157.5.	
	
CHECK HOW TO USE THE WAVE TRANSMISSION SCRIPT FOR CLOSED GATES!! (overtopping)	ANS--->[wavetrans input_SP2 output_Dir --closed]
