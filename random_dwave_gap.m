function [ D ] = random_dwave_gap( qx,qy,D0,n_harmonics )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

theta=atan(qy./qx);

D=zeros(size(qx));
% 
for i=1:n_harmonics
    n=4*(i-1)+2;
    D=D+randpm*cos(n*theta);

end

D=(D./(abs(max(D(:)))))*D0;

m_px=ceil(size(qx,1)/2);

D(m_px,m_px)=(D(m_px,m_px+1)+D(m_px,m_px-1)+D(m_px+1,m_px)+D(m_px-1,m_px))/4;


end

