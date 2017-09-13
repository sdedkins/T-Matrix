function [ dnr ] = deltaDOS( A11r, A22r )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

n_q=size(A11r,1);
n_E=size(A11r,3);
dnr = zeros(n_q,n_q,n_E);

for k=1:n_E  
    dnr(:,:,k) = -imag(A11r(:,:,k)+A22r(:,:,n_E-k+1))/pi/2 ;
end


end

