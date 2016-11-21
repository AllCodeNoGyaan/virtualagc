### FILE="Main.annotation"
## Copyright:	Public domain.
## Filename:	DUMMY_206_INITIALIZATION.agc
## Purpose:	A module for revision 0 of BURST120 (Sunburst). It 
##		is part of the source code for the Lunar Module's
##		(LM) Apollo Guidance Computer (AGC) for Apollo 5.
## Assembler:	yaYUL
## Contact:	Ron Burkey <info@sandroid.org>.
## Website:	www.ibiblio.org/apollo/index.html
## Mod history:	2016-09-30 RSB	Created draft version.
##		2017-10-30 RSB	Finished transcription.

## Page 869
# PROGRAM NAME - BEGIN206
# MOD. NO. 3
# MOD BY - D. LICKLY AND J. SAMPSON
# DATE - NOV. 22, 1966
# LOG SECTION - DUMMY 206 INITIALIZATION
# ASSEMBLY - SUNBURST REVISION 36

# FUNCTIONAL DESCRIPTION - START UP TO TWO DELAYED JOBS OR TASKS AFTER SLAP1 FOR SIMULATION PURPOSES.

# FIXED INITIALIZATION REQUIRED - PATCH STARTDT1 AND STARTDT2 TO REPRESENT THE TIME2,TIME1 VALUE AT THE TIME AT
#                                   WHICH THE JOBS OR TASKS ARE TO BEGIN
#				  PATCH CADR1 AND CADR2 IF SOME OTHER TASKS THAN TASK1 AND TASK2 ARE TO BE USED
#				  PATCH CADR3 AND CADR4 TO THE 2CADR OF THE JOBS TO BE STARTED
#				  PATCH 206BEGIN TO TC ENDOFJOB IF ONLY ONLY ONE TASK OR JOB IS TO BE STARTED
#				  PATCH TASK1 AND TASK2 WITH DIFFERENT PRIORITIES IF DESIRED
# SUBROUTINES CALLED - FINDVAC, WAITLIST

# NORMAL EXIT MODES - ENDOFJOB, TASKOVER

# ALARM OR ABORT EXIT MODES - NONE

# OUTPUT - 2 WAITLIST OR FINDVAC CALLS FOR THE 2CADRS PATCHED IN

# ERASABLE INITIALIZATION REQUIRED - NONE

# DEBRIS - ITEMP1, CENTRALS, ERASABLES IN SUBROUTINES CALLED

# NOTES - SINCE ONLY THE LOW ORDER PART OF STARTDT1 AND STARTDT2 ARE USED OT COMPUTE THE DELTAT FOR WAITLIST, THE
#   REQUIRED TASKS AND JOBS WILL BE CALLED WITHINT 163.84 SECONDS


		BANK	35
		
BEGIN206	INHINT

		CS	TIME1		# PATCH SLAP1 TO COME HERE TO START UP TWO
		AD	STARTDT1 +1	#   DELAYED TASKS OR JOBS FOR SIMULATIONS
		AD	BIT14
		AD	BIT14
		XCH	ITEMP1
		
		CA	ITEMP1
		TC	WAITLIST
		EBANK=	ITEMP1
CADR1		2CADR	TASK1		# MAY BE PATCHED FOR ANOTHER TASK

206BEGIN	CS	TIME1		# PATCH TO TC ENDOFJOB TO START 1 TASK
		AD	STARTDT2 +1
		AD	BIT14
## Page 870
		AD	BIT14
		XCH	ITEMP1
		
		CA	ITEMP1
		TC	WAITLIST
		EBANK=	ITEMP1
CADR2		2CADR	TASK2		# COULD BE PATCHED

		TC	ENDOFJOB
		
		
STARTDT1	2DEC	600		# PATCH

STARTDT2	2DEC	200		# PATCH

TASK1		CAF	PRIO15		# ..OR YOUR OWN PRIORITY..
		TC	FINDVAC
CADR3		OCT	77777		# BETTER PATCH A 2CADR HERE
		OCT	77777
		TC	TASKOVER
		
TASK2		CAF	PRIO20
		TC	FINDVAC
CADR4		OCT	77777		# ..HERE ALSO..
		OCT	77777
		TC	TASKOVER
	