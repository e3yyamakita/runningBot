function dpcom = dpcom(params,x,z)
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

%DPCOM
%    DPCOM = DPCOM(A1,A2,A3,A4,A5,A6,A7,C1,C2,DQ1,DQ2,DQ3,DQ4,DQ5,DQ6,DQ7,DQ8,DQ9,DQ10,L1,L2,L4,L5,L7,M1,M2,M3,M4,M5,M6,M7,MW,Q3,Q4,Q5,Q6,Q7,Q8,Q9,Q10)

%    This function was generated by the Symbolic Math Toolbox version 23.2.
%    2024/02/13 21:53:43

t2 = cos(q3);
t3 = sin(q3);
t4 = dq3+dq5;
t5 = dq3+dq8;
t6 = q3+q5;
t7 = q3+q8;
t16 = -c1;
t17 = -c2;
t18 = -dq1;
t19 = -q4;
t35 = m1+m2+m3+m4+m5+m6+m7+mw;
t8 = dq6+t4;
t9 = dq9+t5;
t10 = cos(t6);
t11 = cos(t7);
t12 = q6+t6;
t13 = q9+t7;
t14 = sin(t6);
t15 = sin(t7);
t28 = a3+t16;
t29 = a6+t17;
t30 = l7+t19;
t36 = 1.0./t35;
t20 = cos(t12);
t21 = cos(t13);
t22 = q7+t12;
t23 = q10+t13;
t24 = sin(t12);
t25 = sin(t13);
t26 = dq7+t8;
t27 = dq10+t9;
t31 = l1.*t4.*t10;
t32 = l4.*t5.*t11;
t33 = l1.*t4.*t14;
t34 = l4.*t5.*t15;
dpcom = [-t36.*(-m7.*(dq1-a7.*dq3.*t3)-m1.*(dq1-a1.*t4.*t14)-m4.*(dq1-a4.*t5.*t15)+mw.*(t18+dq4.*t2+dq3.*t3.*t30)+m2.*(t18+t33+a2.*t8.*t24)+m5.*(t18+t34+a5.*t9.*t25)+m3.*(t18+t33+t26.*t28.*sin(t22)+l2.*t8.*t24)+m6.*(t18+t34+t27.*t29.*sin(t23)+l5.*t9.*t25)),t36.*(m7.*(dq2+a7.*dq3.*t2)+m1.*(dq2+a1.*t4.*t10)+m4.*(dq2+a4.*t5.*t11)+mw.*(dq2-dq4.*t3+dq3.*t2.*t30)+m2.*(dq2+t31+a2.*t8.*t20)+m5.*(dq2+t32+a5.*t9.*t21)+m3.*(dq2+t31+t26.*t28.*cos(t22)+l2.*t8.*t20)+m6.*(dq2+t32+t27.*t29.*cos(t23)+l5.*t9.*t21))];
end
