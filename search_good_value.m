global v step initialized tiptoe_upper_bound tiptoe_bound_init_guess step_lb flags mode1N mode2N mode3N mode4N periodic_accuracy_bound alpha
initialized = 1;



flags = Flags;
flags.use_sea = true;
flags.use_ankle_sea = true;
flags.use_wobbling_mass = true;
flags.optimize_mw = true;
flags.optimize_k = true;
flags.runtype = 0;  %0 = flatfoot; 1,2 = forefoot/backfoot (with kicking phase)
                                  %3,4 = forefoot/backfoot (without kicking phase)
                                  %5,6 = forefoot/backfoot (without flatfoot)
flags.optimize_vmode = 1;   %1/v become function instead of SR
flags.check()

periodic_accuracy_bound = 1e-3;
alpha = 1;
flags.use_ankle_sea = false;
for source = ["+results/2024-01-10_17-15-59-flat-vopt-S.mat"]
    init_guess_source = load(source,"result").result;
    for mode1N = 6
        for mode2N = 9
            for mode3N = 3
                for mode4N = 6
                    for vNow = [12]
                        v = vNow;
                        for stepNow = [1.9,2]
                            step = stepNow;
                            step_lb = max(step/2,step-1); %Lower bound of step length
                            for tiptoenow = 1e-1
                                tiptoe_upper_bound = tiptoenow;
                                tiptoe_bound_init_guess = tiptoenow;
                                for runtype = [0]
                                    for vmode = [1]
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
end

flags.optimize_mw = true;
flags.optimize_k = true;
for source = ["+results/2024-01-10_17-15-59-flat-vopt-S.mat"]
    init_guess_source = load(source,"result").result;
    for mode1N = 6
        for mode2N = 9
            for mode3N = 3
                for mode4N = 6
                    for vNow = [12]
                        v = vNow;
                        for stepNow = [1.9,2]
                            step = stepNow;
                            step_lb = max(step/2,step-1); %Lower bound of step length
                            for tiptoenow = 1e-1
                                tiptoe_upper_bound = tiptoenow;
                                tiptoe_bound_init_guess = tiptoenow;
                                for runtype = [0]
                                    for vmode = [1]
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
end


%CASADI options used
%       casadi_options.ipopt.max_iter = 50000;
%       casadi_options.ipopt.acceptable_iter = 0;
%       casadi_options.ipopt.acceptable_tol = 1e0;

%       casadi_options.ipopt.expect_infeasible_problem_ctol = 1e-2;
%       casadi_options.ipopt.required_infeasibility_reduction = 0.92;
%       casadi_options.ipopt.acceptable_compl_inf_tol = 1e2;    
%       casadi_options.ipopt.acceptable_constr_viol_tol = 1e-4;
   
%C:\Users\ashaw\AppData\Roaming\MathWorks\MATLAB Add-Ons\Collections\OpenOCL - Open Optimal Control Library\+ocl\+casadi\CasadiSolver.m