# How to Use
1. download openocl library from https://github.com/OpenOCL/OpenOCL and add this to the path
2. first execute `create_model.create_model`
  - this command generate some model file under +SEA_model directory
3. execute `main_run_optimization`


# settings
- ipopt.opt file
  - you can set the number of max iteration.

- params.m
  - in this file, specific values for the model of a biped robot are discribed.

- InitialGuess.m
  - in this file, initial guess is described
  - in line 21 of main_run_optimization, if you set true, you can see the shape of initial guess.

- +optimizer directory
  - in this directory, there are some matlab files used in optimization problem settings

- main_run_optimization (main file)
  - line 6-17, you can set 
    - velocity
    - step (not fixed value, but used for initial guess)
    - flags (Whether or not to use sea and wobbling mass and to optimize mw and spring constant)
  - line 42,46, you can set the approximate ratio of each period

# directory explanation
- +output directory
  - there are some matlab file to see the optimization result
  - animation function
    - in console, execute e.g.`output.animation(result, 2, 0.2, true, "movie_for_sice/result-7-opt.mp4")`
    - we can see the result with animation
  - snapshot function
    - in console, execute `output.snapshot(result)`
    - we can see the snapshot of running
  - in +plot directory 
    - there are some files to plot detail information
    - execute `output.plot_result(result)`
      - this execute all files under the +plot directory 

- +console directory 
  - The terminal logs of optimization calculations are stored under this directory

- +results directory
  - the all optimization results are stored in this directory.
  - execute e.g.`load('+results/2021-10-28_19-28-28.mat')`
    - this enable to load the past optimization result.