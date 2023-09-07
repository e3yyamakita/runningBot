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
