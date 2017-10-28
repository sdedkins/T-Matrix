function [ D,coeffs ] = random_swave_gap( qx,qy,D0,n_harmonics )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

theta=atan(qy./qx);

coeffs=zeros(n_harmonics,1);

coeffs(1)=randpm;
D=repmat(coeffs(1),size(qx));

% 
for i=1:n_harmonics
    
    coeffs(i+1)=randpm;
    D=D+coeffs(i+1)*cos(4*i*theta);

end

D=(D./(abs(max(D(:)))))*D0;

m_px=ceil(size(qx,1)/2);

D(m_px,m_px)=(D(m_px,m_px+1)+D(m_px,m_px-1)+D(m_px+1,m_px)+D(m_px-1,m_px))/4;


end

