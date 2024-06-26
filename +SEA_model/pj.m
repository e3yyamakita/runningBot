function pj = pj(params,x)
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

%PJ
%    PJ = PJ(C1,C2,L1,L2,L3,L4,L5,L6,L7,Q1,Q2,Q3,Q5,Q6,Q7,Q8,Q9,Q10)

%    This function was generated by the Symbolic Math Toolbox version 23.2.
%    2024/02/13 21:53:42

t2 = q3+q5;
t3 = q3+q8;
t10 = -l3;
t11 = -l6;
t4 = cos(t2);
t5 = cos(t3);
t6 = q6+t2;
t7 = q9+t3;
t8 = sin(t2);
t9 = sin(t3);
t24 = c1+t10;
t25 = c2+t11;
t12 = cos(t6);
t13 = cos(t7);
t14 = q7+t6;
t15 = q10+t7;
t16 = sin(t6);
t17 = sin(t7);
t18 = l1.*t4;
t19 = l4.*t5;
t20 = l1.*t8;
t21 = l4.*t9;
t22 = cos(t14);
t23 = cos(t15);
t26 = sin(t14);
t27 = sin(t15);
t28 = l2.*t12;
t29 = l5.*t13;
t30 = l2.*t16;
t31 = l5.*t17;
pj = reshape([q1+t18,q1+t18+t28,q1+t18+t28-t22.*t24,q1+t18+t28-c1.*t22,q1+t19,q1+t19+t29,q1+t19+t29-t23.*t25,q1+t19+t29-c2.*t23,q1+l7.*cos(q3),q2+t20,q2+t20+t30,q2+t20+t30-t24.*t26,q2+t20+t30-c1.*t26,q2+t21,q2+t21+t31,q2+t21+t31-t25.*t27,q2+t21+t31-c2.*t27,q2+l7.*sin(q3)],[9,2]);
end
