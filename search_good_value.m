global v step initialized tiptoe_upper_bound tiptoe_bound_init_guess step_lb flags mode1N mode2N mode3N mode4N periodic_accuracy_bound
initialized = 1;



flags = Flags;
flags.use_sea = true;
flags.use_ankle_sea = false;
flags.use_wobbling_mass = true;
flags.optimize_mw = true;
flags.optimize_k = true;
flags.runtype = 0;  %0 = flatfoot; 1 = forefoot; 2 = backfoot
flags.optimize_vmode = 1;   %1/v become function instead of SR
flags.check()

periodic_accuracy_bound = 1e-3;
init_guess_source = load("GOOD_FOREFOOT_RUNNING.mat","result").result;


for mode1N = 6
    for mode2N = 9
        for mode3N = 4
            for mode4N = 6
                for vNow = 8
                    v = vNow;
                    for stepNow = 1.65:0.05:1.85
                        step = stepNow;
                        step_lb = max(step/2,step-1); %Lower bound of step length
                        for tiptoenow = 0.1
                            tiptoe_upper_bound = tiptoenow;
                            tiptoe_bound_init_guess = tiptoenow;
                            for runtype = 1
                                for vmode = 1
                                    flags.runtype = runtype;
                                    flags.optimize_vmode = vmode;
                                    [result,sol,sol_info] = main_run_optimization(mode1N,mode2N,mode3N,mode4N,init_guess_source);
                                end
                            end
                        end
                    end
                end
            end
        end
    end  
end

%CASADI options used
%       casadi_options.ipopt.max_iter = 50000;
%       casadi_options.ipopt.acceptable_iter = 0;
%       casadi_options.ipopt.acceptable_tol = 1e0;
%       casadi_options.ipopt.expect_infeasible_problem_ctol = 1e-2;
%       casadi_options.ipopt.required_infeasibility_reduction = 0.92;
%       casadi_options.ipopt.acceptable_compl_inf_tol = 1e1;    
%       casadi_options.ipopt.acceptable_constr_viol_tol = 1e-4;
   
%C:\Users\ashaw\AppData\Roaming\MathWorks\MATLAB Add-Ons\Collections\OpenOCL - Open Optimal Control Library\+ocl\+casadi\CasadiSolver.m