params;

close all;
f = figure;
plot([-10 10],[0 0],'k')
hold on
axis equal
ylim([-0.2 1.8])
xlim([-0.8 2])
formatSpec = 'time: %.4f';
title_handle = title(sprintf(formatSpec, 0.0));


%% set parameter
pi = 3.121592;

th = [pi;0;pi/4;pi+0.2;5/4*pi;pi*3/4];
dth = [0;0;0;0;0;0];
ddth = [0;0;0;0;0;0];

xb = 0.8;
yb = 0.8;
dxb = 0;
dyb = 0;
ddxb = 0;
ddyb = 0;
thb = pi/4;
ddthb = 0;

lwm = 0;

%% link position calculation

pj = zeros(10,2);
pb = [xb yb];

th_abs = [th(1)+thb;th(2)+th(1)+thb;th(3)+th(2)+th(1)+thb;
    th(4)+thb;th(5)+th(4)+thb;th(6)+th(5)+th(4)+thb;thb];
ddth_abs = [ddth(1)+ddthb;ddth(2)+ddth(1)+ddthb;ddth(3)+ddth(2)+ddth(1)+ddthb;
ddth(4)+ddthb;ddth(5)+ddth(4)+ddthb;ddth(6)+ddth(5)+ddth(4)+ddthb];


pj(1,:) = pb              +  params.l1              * [cos(th_abs(1)) sin(th_abs(1))]; %leg1 knee
pj(2,:) = pj(1,:) +  params.l2              * [cos(th_abs(2)) sin(th_abs(2))]; %leg1 ankle
pj(3,:) = pj(2,:) + (params.l3 - params.c1) * [cos(th_abs(3)) sin(th_abs(3))]; %leg1 toe
pj(4,:) = pj(2,:) -  params.c1              * [cos(th_abs(3)) sin(th_abs(3))]; %leg1 heel
pj(5,:) = pb      +  params.l4              * [cos(th_abs(4)) sin(th_abs(4))]; %leg2 knee
pj(6,:) = pj(5,:) +  params.l5              * [cos(th_abs(5)) sin(th_abs(5))]; %leg2 ankle
pj(7,:) = pj(6,:) + (params.l6 - params.c2) * [cos(th_abs(6)) sin(th_abs(6))]; %leg2 toe
pj(8,:) = pj(6,:) -  params.c2              * [cos(th_abs(6)) sin(th_abs(6))]; %leg2 heel
pj(9,:) = pb      +  params.l7              * [cos(th_abs(7)) sin(th_abs(7))]; %head
pj(10,:) = pb      + (params.l7 - lwm    )  * [cos(th_abs(7)) sin(th_abs(7))];


hold on;
l1 = line([xb   ,pj(1,1)],[yb   ,pj(1,2)]);
l2 = line([pj(1,1),pj(2,1)],[pj(1,2),pj(2,2)]);
l3 = line([pj(3,1),pj(4,1)],[pj(3,2),pj(4,2)]);
l4 = line([xb   ,pj(5,1)],[yb   ,pj(5,2)]);
l5 = line([pj(5,1),pj(6,1)],[pj(5,2),pj(6,2)]);
l6 = line([pj(7,1),pj(8,1)],[pj(7,2),pj(8,2)]);
l7 = line([xb   ,pj(9,1)],[yb   ,pj(9,2)]);
l8 = plot(pj(10,1),pj(10,2),'o','color',[38,124,185]/255,'MarkerSize',7);

%% zmp calculation
m = [params.m1;params.m2;params.m3;params.m4;params.m5;params.m6;params.m7];
I = [params.i1;params.i2;params.i3;params.i4;params.i5;params.i6;params.i7];
g = params.g;


% dL = I.'*ddth_abs + pcx.'*diag(m)*ddpcy - pcy.'*diag(m)*ddpcx;
% zmp_x = (sum(m)*g*xcom + dL)/(sum(m)*(ddycom + g));