function dpc = dpc(params,x,z)
global flags

g = params.g;

m1 = params.m1;
m2 = params.m2;
m3 = params.m3;
m4 = params.m4;
m5 = params.m5;
m6 = params.m6;
m7 = params.m7;

if flags.optimize_mw
  mw = x.mw;
else
  mw = params.mw;
end

I1 = params.i1;
I2 = params.i2;
I3 = params.i3;
I4 = params.i4;
I5 = params.i5;
I6 = params.i6;
I7 = params.i7;

l1 = params.l1;
l2 = params.l2;
l3 = params.l3;
l4 = params.l4;
l5 = params.l5;
l6 = params.l6;
l7 = params.l7;

a1 = params.a1;
a2 = params.a2;
a3 = params.a3;
a4 = params.a4;
a5 = params.a5;
a6 = params.a6;
a7 = params.a7;

c1 = params.c1;
c2 = params.c2;

q1 = x.xb;
q2 = x.yb;
q3 = x.thb;
q4 = x.lw;
q5 = x.th1;
q6 = x.th2;
q7 = x.th3;
q8 = x.th4;
q9 = x.th5;
q10 = x.th6;

dq1 = x.dxb;
dq2 = x.dyb;
dq3 = x.dthb;
dq4 = x.dlw;
dq5 = x.dth1;
dq6 = x.dth2;
dq7 = x.dth3;
dq8 = x.dth4;
dq9 = x.dth5;
dq10 = x.dth6;

d2q1 = z.ddxb;
d2q2 = z.ddyb;
d2q3 = z.ddthb;
d2q4 = z.ddlw;
d2q5 = z.ddth1;
d2q6 = z.ddth2;
d2q7 = z.ddth3;
d2q8 = z.ddth4;
d2q9 = z.ddth5;
d2q10 = z.ddth6;

%DPC
%    DPC = DPC(A1,A2,A3,A4,A5,A6,A7,C1,C2,DQ1,DQ2,DQ3,DQ5,DQ6,DQ7,DQ8,DQ9,DQ10,L1,L2,L4,L5,Q3,Q5,Q6,Q7,Q8,Q9,Q10)

%    This function was generated by the Symbolic Math Toolbox version 23.2.
%    2024/02/13 21:53:43

t2 = dq3+dq5;
t3 = dq3+dq8;
t4 = q3+q5;
t5 = q3+q8;
t14 = -c1;
t15 = -c2;
t6 = dq6+t2;
t7 = dq9+t3;
t8 = cos(t4);
t9 = cos(t5);
t10 = q6+t4;
t11 = q9+t5;
t12 = sin(t4);
t13 = sin(t5);
t24 = a3+t14;
t25 = a6+t15;
t16 = cos(t10);
t17 = cos(t11);
t18 = q7+t10;
t19 = q10+t11;
t20 = sin(t10);
t21 = sin(t11);
t22 = dq7+t6;
t23 = dq10+t7;
t26 = l1.*t2.*t8;
t27 = l4.*t3.*t9;
t28 = l1.*t2.*t12;
t29 = l4.*t3.*t13;
t30 = -t28;
t31 = -t29;
dpc = reshape([dq1-a1.*t2.*t12,dq1+t30-a2.*t6.*t20,dq1+t30-t22.*t24.*sin(t18)-l2.*t6.*t20,dq1-a4.*t3.*t13,dq1+t31-a5.*t7.*t21,dq1+t31-t23.*t25.*sin(t19)-l5.*t7.*t21,dq1-a7.*dq3.*sin(q3),dq2+a1.*t2.*t8,dq2+t26+a2.*t6.*t16,dq2+t26+t22.*t24.*cos(t18)+l2.*t6.*t16,dq2+a4.*t3.*t9,dq2+t27+a5.*t7.*t17,dq2+t27+t23.*t25.*cos(t19)+l5.*t7.*t17,dq2+a7.*dq3.*cos(q3)],[7,2]);
end
