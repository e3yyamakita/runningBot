function [th_abs,dth_abs,ddth_abs] = calculate_absolute_angle(th, dth, ddth, thb, dthb,ddthb)

th_abs = [
    thb + th(1);
    thb + th(1) + th(2);
    thb + th(1) + th(2) + th(3);
    thb + th(4);
    thb + th(4) + th(5);
    thb + th(4) + th(5) + th(6);
    thb
    ];
dth_abs = [
    dthb + dth(1);
    dthb + dth(1) + dth(2);
    dthb + dth(1) + dth(2) + dth(3);
    dthb + dth(4);
    dthb + dth(4) + dth(5);
    dthb + dth(4) + dth(5) + dth(6);
    dthb
    ];

ddth_abs = [
  ddthb + ddth(1);
  ddthb + ddth(1) + ddth(2);
  ddthb + ddth(1) + ddth(2) + ddth(3);
  ddthb + ddth(4);
  ddthb + ddth(4) + ddth(5);
  ddthb + ddth(4) + ddth(5) + ddth(6);
  ddthb
  ];

end