This is a quick guide/explanation to what the important files are and what each folder is

How to use:
Set the wanted conditions in search_good_value.m and run it
Solver settings are set in main_run_optimization
Problem definition done by modifying files in +optimizer, or main_run_optimization for phase description
results will appear in +results, logged with the date/time.
console logs will be in +console
If you need to modify the dynamics or add new parts, check create_model to automatically generate a script for it

search_good_value
	RUN THIS PROGRAM, NOT THE MAIN_RUN_OPTIMIZATION
	run through multiple sets of values consecutively. Feel free to modify for loop to run a lot of simulations.
main_run_optimization
	runs the optimization program with specified values. not called directly by user.
InitialGuess.m and InitialGuess_auto
	not used, but could be useful for learning how initial guess works
params.m
	default mechanical parameters

+Inerter_model
	Inerter model code (not used in my thesis, might need checking)
+SEA_model
	Codes generated from +create_model to calculate robot's dynamics/equation of motion matrices. We don't usually generate or modify it directly.
+console
	Console logs of tests
+create_model
	create_model.m creates the dynamics code in +SEA_model.
	modify_function modifies the created files to add suffixes to them
+optimizer
	Main code that describes the optimization problem. MODIFY FILES IN HERE TO DESCRIBE YOUR PROBLEM
	dae1,2,3,4,base
		the differential equations for the corresponding phase
		_base are ones that are the same in all phases (for example, constant "states" and time)
	gridconstraints 1,2,3,4,base
		constraints enforced throughout each phases.
		_base are enforced always
	pathcosts,terminalcost
		cost functions
	trans_ankle_touchdown
		phase transfer function, with discontinuous velocity change by impact at the ankle
	trans_stand2float
		phase transfer function, simply matches the position and velocity
	vars1,2,3,4,base
		opimization problem variable declaration, include states, control inputs, and algvars (those used in differential equations)
+output
	Result class file and other visualization tools
	Result.m
		result class file, organizes the raw solution file into an easily readable one
	plot_result
		plots the trajectory of most of the variables, phases are separated by colors
	animation
		plays animation from [result] file [loop] number of steps, [playratio] speed, [save_video] (true/false) to mp4 file with [filename] if you want
+results
	result of tests
+utils
	utility files
	copy_initial_guess_complete
		set the input result file as initial guess for current problem
		probably one of the worst code here. will need rewriting.
	check_violation
		print out violation of the periodicity constraint

Potential Problems:
Q: "I added a new optimization variable but it isn't recorded in the result file"
A. Add it in the Result.m class file as well so that it pulls the variable from the sol file.

Q: "There is some error about the state derivative after I added a variable"
A. Possibly a problem with not having an initial guess. Check if all variables are correctly pulled in copy_initial_guess_complete

Contact:
ashawin.wis@gmail.com