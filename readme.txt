16 feb
-Remember to update the repository with the new scripts
-change the run script to read scripts from repository not 0prepare

15 feb:
-Dont forget to do dos2unix with the submit script otherwise the folder names are not found!
-pip install netCDF4 (on the h6)
-update all scripts for figure properties on the H6
-plmaps only for OS? why does it take so long to run? FIXED
-make a script (later) telling us which runs are finished or still need to be done Caroline did it.


14 feb: 

- to be done run_test5: 3 directions, 3 speeds, 4 water levels
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
RUN_TEST6 submit the same way the runs are submitted for Amazon, testing goes well, extra editing of the pythong scripts to work for different types of possible results
RUN_TEST6_2it testing runs with 2 iterations to check the python post-processing scritps
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
