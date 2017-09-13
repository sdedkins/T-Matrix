function [ E_tb] = cuprate_dispersion( qx,qy )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%calculate TB model energies as per Wang and Lee QPI PRB, who used Norman
t1 = 0.1305; 
t2 = -0.5951;
t3 = 0.1636;
t4 = -0.0519;
t5 = -0.1117;
t6 = 0.0510;
E_tb = t1 + t2*(cos(pi*qx)+cos(pi*qy))/2 + t3*cos(pi*qx).*cos(pi*qy) + t4*(cos(2*pi*qx)+cos(2*pi*qy))/2 ...
         +t5*(cos(2*pi*qx).*cos(pi*qy)+cos(pi*qx).*cos(2*pi*qy))/2 + t6*cos(2*pi*qx).*cos(2*pi*qy);

end

