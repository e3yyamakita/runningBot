function [ddq, ddphi] = decompose_algvars(z)

    ddq = [
    z.ddxb;
    z.ddyb;
    z.ddthb;
    z.ddlw;
    z.ddth1;
    z.ddth2;
    z.ddth3;
    z.ddth4;
    z.ddth5;
    z.ddth6
    ];

  ddphi = [
    z.ddphi1;
    z.ddphi2;
    z.ddphi3;
    z.ddphi4;
    z.ddphi5;
    z.ddphi6
    ];

end