function [  ] = randswave( )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

theta=linspace(0,pi,500);

Delta=randpm;
cutoff=2;

for i=1:cutoff

    Delta=Delta+randpm*cos(4*i*theta);

end

Delta=Delta/(max(abs(Delta(:))));

figure(11) 

plot(theta,Delta,'-k');
ylim([-1,1]);

