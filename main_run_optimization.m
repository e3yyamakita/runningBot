function [result,sol,sol_info] = main_run_optimization(mode1N,mode2N,mode3N,mode4N,init_guess_source)
    close all;
    clc;
    
    clearvars -except mode1N mode2N mode3N mode4N init_guess_source;
    global v step flags tiptoe_upper_bound tiptoe_bound_init_guess alpha
    
    % ↓ optimization setting ↓
    period_init_guess = step/v;
    opt = ocl.casadi.CasadiOptions();
    opt.ipopt.max_iter = 40000;
    opt.ipopt.acceptable_iter = 0;
    opt.ipopt.acceptable_tol = 1e0;
    opt.ipopt.expect_infeasible_problem_ctol = 1e-2;
    opt.ipopt.required_infeasibility_reduction = 0.92;
    opt.ipopt.acceptable_compl_inf_tol = 1e2;    
    opt.ipopt.acceptable_constr_viol_tol = 1e-3;
    % ↑ optimization setting ↑
    
    if flags.runtype == 0
        tiptoe_upper_bound = 0;
        tiptoe_bound_init_guess = 0;
    end

    tiptoe_duration_bound = [0,tiptoe_upper_bound];
   
    %ig = InitialGuess(step, false);
    %ig.draw();

    if ismember(flags.runtype, [0:4])
        mode1 = ocl.Stage( ...
          [], ...
          'vars', @optimizer.vars1, ...
          'dae', @optimizer.dae1, ...
          'pathcosts', @optimizer.pathcosts, ...
          'gridconstraints', @optimizer.gridconstraints1, ...
          'N', mode1N, 'd', 3); %Full foot support leg
        utils.copy_initial_guess_complete(mode1,1,init_guess_source);
    end
    
    mode2 = ocl.Stage( ...
      [], ...
      'vars', @optimizer.vars2, ...
      'dae', @optimizer.dae2, ...
      'pathcosts', @optimizer.pathcosts, ...
      'terminalcost', @optimizer.terminalcost, ...
      'gridconstraints', @optimizer.gridconstraints2, ...
      'N', mode2N, 'd', 3); %Airborne
    utils.copy_initial_guess_complete(mode2,2,init_guess_source);
    
    if  ismember(flags.runtype, [1:6])
      mode3 = ocl.Stage( ...
      [], ...
      'vars', @optimizer.vars3, ...
      'dae', @optimizer.dae3, ...
      'pathcosts', @optimizer.pathcosts, ...
      'gridconstraints', @optimizer.gridconstraints3, ...
      'N', mode3N, 'd', 3); % Tiptoe Touchdown
  
      utils.copy_initial_guess_complete(mode3,3,init_guess_source);
    end
    
    if ismember(flags.runtype, [1,2])
      mode4 = ocl.Stage( ...
      [], ...
      'vars', @optimizer.vars4, ...
      'dae', @optimizer.dae4, ...
      'pathcosts', @optimizer.pathcosts, ...
      'gridconstraints', @optimizer.gridconstraints4, ...
      'N', mode4N, 'd', 3); % Tiptoe Touchdown
      utils.copy_initial_guess_complete(mode4,4,init_guess_source);
    end

    if  flags.runtype == 0
        period_bound = period_init_guess*[0.2, 0.6, 0.8, 1.2];
        mode1.setInitialStateBounds('time', 0);
        mode1.setEndStateBounds('time', period_bound(1), period_bound(2));
        mode2.setInitialStateBounds('time', period_bound(1), period_bound(2));
        mode2.setEndStateBounds('time', period_bound(3), period_bound(4));
    else
        period_bound = period_init_guess*[tiptoe_upper_bound 0.2 0.5 1];
        mode3.setInitialStateBounds('time', 0);

        mode3.setEndStateBounds('time', 0, tiptoe_duration_bound(2));
        mode1.setInitialStateBounds('time', 0, tiptoe_duration_bound(2));

%         mode3.setEndStateBounds('time', period_bound(1)*0.8, period_bound(1)*1.2);
%         mode1.setInitialStateBounds('time', period_bound(1)*0.8, period_bound(1)*1.2);
% 
%         mode1.setEndStateBounds('time', period_bound(2)*0.8, period_bound(2)*1.2);
%         mode4.setInitialStateBounds('time', period_bound(2)*0.8, period_bound(2)*1.2);
% 
%         mode4.setEndStateBounds('time', period_bound(3)*0.8, period_bound(3)*1.2);
%         mode2.setInitialStateBounds('time', period_bound(3)*0.8, period_bound(3)*1.2);

        mode2.setEndStateBounds('time', period_bound(4)*0.5, period_bound(4)*1.5);
    end



    if flags.runtype == 0
        ocp = ocl.MultiStageProblem({mode1,mode2}, ...
                                {@optimizer.trans_stand2float},...
                                'casadi_options',opt);
    elseif ismember(flags.runtype, [1,2])                    
        ocp = ocl.MultiStageProblem({mode3,mode1,mode4,mode2}, ...
                                 {@optimizer.trans_ankle_touchdown,@optimizer.trans_stand2float,@optimizer.trans_stand2float},...
                                'casadi_options',opt);
    elseif ismember(flags.runtype, [3,4])
        ocp = ocl.MultiStageProblem({mode3,mode1,mode2}, ...
                                 {@optimizer.trans_ankle_touchdown,@optimizer.trans_stand2float},...
                                'casadi_options',opt);
    elseif ismember(flags.runtype, [5,6])
        ocp = ocl.MultiStageProblem({mode3,mode2}, ...
                                {@optimizer.trans_stand2float},...
                                'casadi_options',opt);
    end
    
    % save console log
    exe_time = now;
    [~,~]=mkdir('+console');
    suffix = ["flat-","fore-","back-","fore3phase-","back3phase-","purefore-","pureback-"];
    veltype = ["vlock-","vopt-"];
    console_filename = join(['+console/' datestr(exe_time,'yyyy-mm-dd_HH-MM-SS-') suffix(flags.runtype+1) veltype(flags.optimize_vmode+1) '.log'],'');
    diary(console_filename)

    % solve
    disp("Starting with ");
    disp([mode1N,mode2N,mode3N,mode4N,v,step,tiptoe_upper_bound]);
    [sol,times, sol_info] = ocp.solve();

    result = output.Result(sol, times, flags, sol_info);

    % save results to file
    %if (sol_info.success || ~strcmp(sol_info.ipopt_stats.return_status,'Infeasible_Problem_Detected'))
        [~,~]=mkdir('+results');
        if (sol_info.success)
           outcome = 'Scs';
        elseif sol_info.ipopt_stats.return_status == "Infeasible_Problem_Detected"
           outcome = 'Inf';
        elseif sol_info.ipopt_stats.return_status == "Maximum_Iterations_Exceeded"
            outcome = 'Max';
        else
            outcome = '???';
        end
        result_filename = convertStringsToChars(join(['+results/' datestr(exe_time,'yyyy-mm-dd_HH-MM-SS-') suffix(flags.runtype+1)  veltype(flags.optimize_vmode+1) outcome '.mat'],''));
        
        save(result_filename,'sol','times','result','flags','v','step');

    %     diary off;

        data_name = convertStringsToChars(join([datestr(exe_time,'yyyy-mm-dd_HH-MM-SS-') suffix(flags.runtype+1) veltype(flags.optimize_vmode+1) outcome],''));
        output.result_txt(result,data_name);
    %end
    diary off
end