function [ E ] = parabolic_band( qx,qy )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

a=-4.5;
b=10;

E=a+b*sqrt(qx.^2+qy.^2);

end

