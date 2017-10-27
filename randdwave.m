function [ ] = randdwave( )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

theta=linspace(0,pi,500);

Delta=randpm*sin(2*theta);
cutoff=1;

for i=1:cutoff

    Delta=Delta+randpm*(sin((4*i+2)*theta));

end

% theta = [theta , theta+pi/2];
% Delta = [Delta , -Delta];

Delta=Delta/(abs(max(Delta(:))));

figure(101); 

plot(theta./pi,Delta,'-k');
ylim([-1,1]);


end

