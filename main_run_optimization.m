
close all;
clc;
clear;
global v step T flags initialized
global mode1N mode2N mode3N

if initialized == 1
else
    disp("Global variables not initialized. Value defaulted.")
    mode1N = 10;
    mode2N = 14;
    mode3N = 1;
    v = 8.0;  % desired velocity
    step = 1.5;
end


% ↓ optimization setting ↓

  % step (approximate)
period = step/v;
T = period;
tiptoe_duration_bound = [0,0.01];

flags = Flags;
flags.use_sea = true;
flags.use_wobbling_mass = true;
flags.optimize_mw = true;
flags.optimize_k = true;
flags.use_inerter = false; %aoyama's inerter at knee and ankle
flags.forefoot = true;  %forefoot running
flags.bird_leg = 0; %reversed knee
flags.optimize_vmode = 0;   %1/v become function instead of SR
flags.check()
% ↑ optimization setting ↑


ig = InitialGuess(step, false);
%ig.draw();

mode3 = ocl.Stage( ...
  [], ...
  'vars', @optimizer.vars3, ...
  'dae', @optimizer.dae3, ...
  'pathcosts', @optimizer.pathcosts, ...
  'gridconstraints', @optimizer.gridconstraints3, ...
  'N', mode3N, 'd', 3); % Tiptoe Touchdown
mode1 = ocl.Stage( ...
  [], ...
  'vars', @optimizer.vars1, ...
  'dae', @optimizer.dae1, ...
  'pathcosts', @optimizer.pathcosts, ...
  'gridconstraints', @optimizer.gridconstraints1, ...
  'N', mode1N, 'd', 3); % With support leg
mode2 = ocl.Stage( ...
  [], ...
  'vars', @optimizer.vars2, ...
  'dae', @optimizer.dae2, ...
  'pathcosts', @optimizer.pathcosts, ...
  'gridconstraints', @optimizer.gridconstraints2, ...
  'N', mode2N, 'd', 3); % Airborne!!!

%                        1end  
period_bound = period*[0.2, 0.4, 0.8, 1.2];
mode3.setInitialStateBounds('time', 0);
mode3.setEndStateBounds('time', tiptoe_duration_bound(1), tiptoe_duration_bound(2));
mode1.setInitialStateBounds('time', tiptoe_duration_bound(1), tiptoe_duration_bound(2));
mode1.setEndStateBounds('time', period_bound(1), period_bound(2));
mode2.setInitialStateBounds('time', period_bound(1), period_bound(2));
mode2.setEndStateBounds('time', period_bound(3), period_bound(4));

ig.set_initial_guess(mode3, mode1, mode2, period, 0.00001);
% load('temp_result.mat', 'result')
% utils.copy_initial_guess([mode3, mode1, mode2],result)

ocp = ocl.MultiStageProblem({mode3,mode1,mode2}, ...
                            {@optimizer.trans_tiptoe_touchdown,@optimizer.trans_stand2float});

                        
% save console log
exe_time = now;
[~,~]=mkdir('+console');
console_filename = ['+console/' datestr(exe_time,'yyyy-mm-dd_HH-MM-SS') '.log'];
diary(console_filename)

% solve
disp("Starting with ");
disp([mode1N,mode2N,mode3N,v,step]);
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