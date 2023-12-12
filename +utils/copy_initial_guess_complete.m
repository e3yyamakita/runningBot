function copy_initial_guess_complete(mode, mode_N, source)
global flags tiptoe_bound_init_guess tiptoe_upper_bound mode1N mode2N mode3N mode4N T

% Completely copies all variables from the source as initial guess
% ModeN (number of data points in a phase) must match the source
% for different sizes, try v2 or v3.

% Works with 2 phase or 4 phase sources. 

if size(source.state_size,2) == 2
    if mode_N == 1
       state_data_grid = [1:source.state_size(1)];
       state_time_grid = normalize(source.time(state_data_grid),'range');
        
       control_data_grid = [1:source.control_size(1)];
       control_time_grid = normalize(source.control_time(control_data_grid),'range');

        
       algvars_data_grid = [1:source.algvars_size(1)];
       algvars_time_grid = normalize(source.algvars_time(algvars_data_grid),'range');
        
        i = 1;
while i < length(state_time_grid)
    while state_time_grid(i) >= state_time_grid(i+1)
        state_time_grid(i) = [];
        state_data_grid(i) = [];
    end
    i=i+1;
end

       mode.initialize('time', state_time_grid,...
           source.time(state_data_grid)+tiptoe_bound_init_guess*ones(size(state_time_grid)));

    elseif mode_N == 2
        state_data_grid = [source.state_size(1)+1:sum(source.state_size(1:2))];
        state_time_grid = normalize(source.time(state_data_grid)-source.time(source.state_size(1)+1),'range');
        
        
        control_data_grid = [source.control_size(1)+1:source.control_size(1)+source.control_size(2)];
        control_time_grid = normalize(source.control_time(control_data_grid)-source.control_time(source.control_size(1)+1),'range');
        
        algvars_data_grid = [source.algvars_size(1)+1:source.algvars_size(1)+source.algvars_size(2)];
        algvars_time_grid = normalize(source.algvars_time(algvars_data_grid)-source.algvars_time(source.algvars_size(1)+1),'range');
        
        i = 1;
while i < length(state_time_grid)
    while state_time_grid(i) >= state_time_grid(i+1)
        state_time_grid(i) = [];
        state_data_grid(i) = [];
    end
    i=i+1;
end
        
        mode.initialize('time', state_time_grid,...
            source.time(state_data_grid)+tiptoe_bound_init_guess*ones(size(state_time_grid)));

    elseif mode_N == 3
        
        state_data_grid = [1 1];
        state_time_grid = [0 1];
        
        control_data_grid = [1 1];
        control_time_grid = [0 1];
        
        algvars_data_grid = [1 1];
        algvars_time_grid = [0 1];
        
        mode.initialize('time', [0 1], [0 tiptoe_bound_init_guess]);
       
    elseif mode_N == 4
        state_data_grid = [source.state_size(1) source.state_size(1)+1];
        state_time_grid = [0 1];
        
        control_data_grid = [source.control_size(1) source.control_size(1)+1];
        control_time_grid = [0 1];
        
        algvars_data_grid = [source.algvars_size(1) source.algvars_size(1)+1];
        algvars_time_grid = [0 1];
        
        %mode.initialize('time', [0 1], source.time(state_data_grid)+tiptoe_upper_bound*ones(size(state_time_grid)));
        mode.initialize('time', [0 1], source.time(state_data_grid)+tiptoe_upper_bound*ones(size(state_time_grid)));
    end
elseif  size(source.state_size,2) == 4
    if mode_N == 1
        
        state_data_grid = [source.state_size(1)+1:sum(source.state_size(1:2))];
        state_time_grid = normalize(source.time(state_data_grid)-source.time(state_data_grid(1)),'range');
        
        control_data_grid = [source.control_size(1)+1:sum(source.control_size(1:2))];
        control_time_grid = normalize(source.control_time(control_data_grid)-source.control_time(control_data_grid(1)),'range');
        
        algvars_data_grid = [source.algvars_size(1)+1:sum(source.algvars_size(1:2))];
        algvars_time_grid = normalize(source.algvars_time(algvars_data_grid)-source.algvars_time(algvars_data_grid(1)),'range');

    elseif mode_N == 2
    
        state_data_grid = [source.state_size(3)+1:sum(source.state_size(1:4))];
        state_time_grid = normalize(source.time(state_data_grid)-source.time(state_data_grid(1)),'range');
        
        control_data_grid = [source.control_size(3)+1:sum(source.control_size(1:4))];
        control_time_grid = normalize(source.control_time(control_data_grid)-source.control_time(control_data_grid(1)),'range'); 
        
        algvars_data_grid = [source.algvars_size(3)+1:sum(source.algvars_size(1:4))];
        algvars_time_grid = normalize(source.algvars_time(algvars_data_grid)-source.algvars_time(algvars_data_grid(1)),'range');        

    elseif mode_N == 3
       
        state_data_grid = [1:source.state_size(1)];
        state_time_grid = normalize(source.time(state_data_grid),'range');
        
        control_data_grid = [1:source.control_size(1)];
        control_time_grid = normalize(source.control_time(control_data_grid),'range');
        
        algvars_data_grid = [1:source.algvars_size(1)];
        algvars_time_grid = normalize(source.algvars_time(algvars_data_grid),'range');
    
    elseif mode_N == 4
        state_data_grid = [source.state_size(2)+1:sum(source.state_size(1:3))];
        state_time_grid = normalize(source.time(state_data_grid)-source.time(state_data_grid(1)),'range');
        
        
        control_data_grid = [source.control_size(2)+1:sum(source.control_size(1:3))];
        control_time_grid = normalize(source.control_time(control_data_grid)-source.control_time(control_data_grid(1)),'range');
        
        algvars_data_grid = [source.algvars_size(2)+1:sum(source.algvars_size(1:3))];
        algvars_time_grid = normalize(source.algvars_time(algvars_data_grid)-source.algvars_time(algvars_data_grid(1)),'range');
    end
    i = 1;
    
while i < length(state_time_grid)-1
    while i < length(state_time_grid)-1 && state_time_grid(i) >= state_time_grid(i+1)
        state_time_grid(i) = [];
        state_data_grid(i) = [];
    end
    i=i+1;
end
   mode.initialize('time', state_time_grid,...
           source.time(state_data_grid));
else
    disp("Dimension mismatch for intial guess")
end

i = 1;
while i < length(state_time_grid)
    while i < length(state_time_grid)-1 && state_time_grid(i) >= state_time_grid(i+1)
        state_time_grid(i) = [];
        state_data_grid(i) = [];
    end
    i=i+1;
end
i=1;
while i < length(control_time_grid)
    while i < length(control_time_grid)-1 && control_time_grid(i) >= control_time_grid(i+1)
        control_time_grid(i) = [];
        control_data_grid(i) = [];
    end
    i=i+1;
end
i=1;
while i < length(algvars_time_grid)
    while i < length(algvars_time_grid)-1 && algvars_time_grid(i) >= algvars_time_grid(i+1)
        algvars_time_grid(i) = [];
        algvars_data_grid(i) = [];
    end
    i=i+1;
end

if min(abs([diff(state_time_grid),diff(control_time_grid),diff(algvars_time_grid)])) == 0
    disp("COPYING FAILED, DUPLICATED VALUES")
end
        
        
        mode.initialize('xb'  , state_time_grid, source.xb(state_data_grid));
        mode.initialize('yb'  , state_time_grid, source.yb(state_data_grid)  );
        mode.initialize('thb' , state_time_grid, source.thb(state_data_grid) );
        %mode.initialize('lw'  , state_time_grid, source.lw(state_data_grid)  );
        mode.initialize('lw'  , state_time_grid, -sin(2*pi*source.time(state_data_grid)/T)*max(abs(source.lw-mean(source.lw)))+mean(source.lw));
        mode.initialize('th1' , state_time_grid, source.th1(state_data_grid) );
        mode.initialize('th2' , state_time_grid, source.th2(state_data_grid) );
        mode.initialize('th3' , state_time_grid, source.th3(state_data_grid) );
        mode.initialize('th4' , state_time_grid, source.th4(state_data_grid) );
        mode.initialize('th5' , state_time_grid, source.th5(state_data_grid) );
        mode.initialize('th6' , state_time_grid, source.th6(state_data_grid) );
        mode.initialize('phi1', state_time_grid, source.phi1(state_data_grid));
        mode.initialize('phi2', state_time_grid, source.phi2(state_data_grid));
        mode.initialize('phi3', state_time_grid, source.phi3(state_data_grid));
        mode.initialize('phi4', state_time_grid, source.phi4(state_data_grid));
        mode.initialize('phi5', state_time_grid, source.phi5(state_data_grid));
        mode.initialize('phi6', state_time_grid, source.phi6(state_data_grid));
        
        mode.initialize('dxb'  , state_time_grid, source.dxb(state_data_grid)  );
        mode.initialize('dyb'  , state_time_grid, source.dyb(state_data_grid)  );
        mode.initialize('dthb' , state_time_grid, source.dthb(state_data_grid) );
        %mode.initialize('dlw'  , state_time_grid, source.dlw(state_data_grid)  );
        mode.initialize('dlw'  , state_time_grid, -2*pi/T*cos(2*pi*source.time(state_data_grid)/T)*max(abs(source.lw-mean(source.lw))));
        mode.initialize('dth1' , state_time_grid, source.dth1(state_data_grid) );
        mode.initialize('dth2' , state_time_grid, source.dth2(state_data_grid) );
        mode.initialize('dth3' , state_time_grid, source.dth3(state_data_grid) );
        mode.initialize('dth4' , state_time_grid, source.dth4(state_data_grid) );
        mode.initialize('dth5' , state_time_grid, source.dth5(state_data_grid) );
        mode.initialize('dth6' , state_time_grid, source.dth6(state_data_grid) );
        mode.initialize('dphi1', state_time_grid, source.dphi1(state_data_grid));
        mode.initialize('dphi2', state_time_grid, source.dphi2(state_data_grid));
        mode.initialize('dphi3', state_time_grid, source.dphi3(state_data_grid));
        mode.initialize('dphi4', state_time_grid, source.dphi4(state_data_grid));
        mode.initialize('dphi5', state_time_grid, source.dphi5(state_data_grid));
        mode.initialize('dphi6', state_time_grid, source.dphi6(state_data_grid));
        
        mode.initialize('ddxb'  , algvars_time_grid, source.ddxb(algvars_data_grid)  );
        mode.initialize('ddyb'  , algvars_time_grid, source.ddyb(algvars_data_grid)  );
        mode.initialize('ddthb' , algvars_time_grid, source.ddthb(algvars_data_grid) );
        %mode.initialize('ddlw'  , algvars_time_grid, source.ddlw(algvars_data_grid)  );
        mode.initialize('ddlw'  , algvars_time_grid, 4*pi^2/T^2*sin(2*pi*source.algvars_time(algvars_data_grid)./T)*max(abs(source.lw-mean(source.lw))));
        mode.initialize('ddth1' , algvars_time_grid, source.ddth1(algvars_data_grid) );
        mode.initialize('ddth2' , algvars_time_grid, source.ddth2(algvars_data_grid) );
        mode.initialize('ddth3' , algvars_time_grid, source.ddth3(algvars_data_grid) );
        mode.initialize('ddth4' , algvars_time_grid, source.ddth4(algvars_data_grid) );
        mode.initialize('ddth5' , algvars_time_grid, source.ddth5(algvars_data_grid) );
        mode.initialize('ddth6' , algvars_time_grid, source.ddth6(algvars_data_grid) );
        mode.initialize('ddphi1', algvars_time_grid, source.ddphi1(algvars_data_grid));
        mode.initialize('ddphi2', algvars_time_grid, source.ddphi2(algvars_data_grid));
        mode.initialize('ddphi3', algvars_time_grid, source.ddphi3(algvars_data_grid));
        mode.initialize('ddphi4', algvars_time_grid, source.ddphi4(algvars_data_grid));
        mode.initialize('ddphi5', algvars_time_grid, source.ddphi5(algvars_data_grid));
        mode.initialize('ddphi6', algvars_time_grid, source.ddphi6(algvars_data_grid));
        
        mode.initialize('u1' , control_time_grid, source.u1(control_data_grid) );
        mode.initialize('u2' , control_time_grid, source.u2(control_data_grid) );
        mode.initialize('u3' , control_time_grid, source.u3(control_data_grid) );
        mode.initialize('u4' , control_time_grid, source.u4(control_data_grid) );
        mode.initialize('u5' , control_time_grid, source.u5(control_data_grid) );
        mode.initialize('u6' , control_time_grid, source.u6(control_data_grid) );
        %mode.initialize('uw' , control_time_grid, source.uw(control_data_grid) );
        mode.initialize('uw' , control_time_grid, ((4*pi^2/T^2)*sin(2*pi*source.algvars_time(control_data_grid)/T)/params.mw*max(abs(source.lw-mean(source.lw))))+params.mw*params.g);

        if source.flags.optimize_k
%           mode.initialize('khip'  , [0 1],source.khip  *ones(1,2));
%           mode.initialize('kknee' , [0 1],source.kknee *ones(1,2));
%           mode.initialize('kankle', [0 1],source.kankle*ones(1,2));
          
          %mode.initialize('khip'  , [0 1],1000  *ones(1,2));
          %mode.initialize('kknee' , [0 1],2000 *ones(1,2));
          %mode.initialize('kankle', [0 1],2000*ones(1,2));
          
          mode.initialize('springK'  , [0 1],[1200,1200;2000,2000;2000,2000]);
        end

        if source.flags.optimize_mw
          mode.initialize('mw'    , [0 1],source.mw    *ones(1,2));
          %mode.initialize('mw'    , [0 1],1.5    *ones(1,2));
          %mode.initialize('mw'  , 1, 0.25);
        end

        if mode_N ~=2
          mode.initialize('fex', algvars_time_grid, source.fex(algvars_data_grid)./source.fey(algvars_data_grid));
          mode.initialize('fey', algvars_time_grid, source.fey(algvars_data_grid));
        end

        if mode_N == 1
          mode.initialize('zmp_x', [1:source.algvars_size(size(source.state_size,2)/2)], source.zmp_x);
          mode.initialize('feth', algvars_time_grid, source.feth(algvars_data_grid));
        end