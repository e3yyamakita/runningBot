function [result,sol,sol_info] = main_run_optimization(mode1N,mode2N,mode3N,mode4N)
    close all;
    clc;
    clearvars -except mode1N mode2N mode3N mode4N;
    global v step T flags initialized tiptoe_upper_bound tiptoe_bound_init_guess

    % ↓ optimization setting ↓
    period_init_guess = step/v;
    T = period_init_guess;
    % ↑ optimization setting ↑

    if flags.runtype == 0
        tiptoe_upper_bound = 0;
        tiptoe_bound_init_guess = 0;
    end

    tiptoe_duration_bound = [0,tiptoe_upper_bound];
    %tiptoe_duration_bound = [1e-4,1e-3];   
    %ig = InitialGuess(step, false);
    %ig.draw();


    mode1 = ocl.Stage( ...
      [], ...
      'vars', @optimizer.vars1, ...
      'dae', @optimizer.dae1, ...
      'pathcosts', @optimizer.pathcosts, ...
      'gridconstraints', @optimizer.gridconstraints1, ...
      'N', mode1N, 'd', 3); %Full foot support leg
    mode2 = ocl.Stage( ...
      [], ...
      'vars', @optimizer.vars2, ...
      'dae', @optimizer.dae2, ...
      'pathcosts', @optimizer.pathcosts, ...
      'terminalcost', @optimizer.terminalcost, ...
      'gridconstraints', @optimizer.gridconstraints2, ...
      'N', mode2N, 'd', 3); %Airborne

    if flags.runtype > 0
      mode3 = ocl.Stage( ...
      [], ...
      'vars', @optimizer.vars3, ...
      'dae', @optimizer.dae3, ...
      'pathcosts', @optimizer.pathcosts, ...
      'gridconstraints', @optimizer.gridconstraints3, ...
      'N', mode3N, 'd', 3); % Tiptoe Touchdown

      mode4 = ocl.Stage( ...
      [], ...
      'vars', @optimizer.vars4, ...
      'dae', @optimizer.dae4, ...
      'pathcosts', @optimizer.pathcosts, ...
      'gridconstraints', @optimizer.gridconstraints4, ...
      'N', mode4N, 'd', 3); % Tiptoe Touchdown

    end


    load('+results/2023-12-09_05-37-09_g.mat', 'result');
    utils.copy_initial_guess_complete(mode1,1,result);
    utils.copy_initial_guess_complete(mode2,2,result);
    if flags.runtype > 0
      utils.copy_initial_guess_complete(mode3,3,result);
      utils.copy_initial_guess_complete(mode4,4,result);
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
                                {@optimizer.trans_stand2float});
    else                        
         ocp = ocl.MultiStageProblem({mode3,mode1,mode4,mode2}, ...
                                 {@optimizer.trans_ankle_touchdown,@optimizer.trans_stand2float,@optimizer.trans_stand2float});
    end

    % save console log
    exe_time = now;
    [~,~]=mkdir('+console');
    console_filename = ['+console/' datestr(exe_time,'yyyy-mm-dd_HH-MM-SS') '.log'];
    diary(console_filename)

    % solve
    disp("Starting with ");
    disp([mode1N,mode2N,mode3N,v,step,tiptoe_upper_bound]);
    [sol,times, sol_info] = ocp.solve();

    result = output.Result(sol, times, flags, sol_info);

    % save results to file
    %if (sol_info.success || ~strcmp(sol_info.ipopt_stats.return_status,'Infeasible_Problem_Detected'))
        [~,~]=mkdir('+results');
        result_filename = [datestr(exe_time,'yyyy-mm-dd_HH-MM-SS') '.mat'];
        save(['+results/' result_filename],'sol','times','result','flags','v','step');

    %     diary off;

        data_name = [datestr(exe_time,'yyyy-mm-dd_HH-MM-SS')];
        output.result_txt(result,data_name);
    %end
    diary off
end