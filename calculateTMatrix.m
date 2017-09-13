function [ T11,T12,T21,T22 ] = calculateTMatrix( G11r,G12r,G21r,G22r,Vs,Vm )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

n_q=size(G11r,1);
n_E=size(G11r,3);

I = eye(2);

%calculate T matrix
T11 = zeros(1,n_E);
T12 = zeros(1,n_E);
T21 = zeros(1,n_E);
T22 = zeros(1,n_E);
sumG_ind = (n_q+1)/2;
    for k=1:n_E
        A = [Vs+Vm, 0.0;...
               0.0, -Vs+Vm];
        B = [G11r(sumG_ind,sumG_ind,k),G12r(sumG_ind,sumG_ind,k);...
            G21r(sumG_ind,sumG_ind,k),G22r(sumG_ind,sumG_ind,k)];
        C = I - A*B;
        T = A/C;
        T11(k) = T(1,1);       
        T12(k) = T(1,2);
        T21(k) = T(2,1);
        T22(k) = T(2,2);    
    end

end

