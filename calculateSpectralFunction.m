function [ A11r, A22r ] = calculateSpectralFunction( G11r,G12r,G21r,G22r,T11,T12,T21,T22)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

n_q=size(G11r,1);
n_E=size(G11r,3);

A11r = zeros(n_q,n_q,n_E);
A22r = zeros(n_q,n_q,n_E);
for k=1:n_E
    for i=1:n_q
        for j=1:n_q
            A11r(i,j,k) = G11r(i,j,k)*T11(k)*G11r(n_q-i+1,n_q-j+1,k)...
                        + G11r(i,j,k)*T12(k)*G21r(n_q-i+1,n_q-j+1,k)...
                        + G12r(i,j,k)*T21(k)*G11r(n_q-i+1,n_q-j+1,k)...
                        + G12r(i,j,k)*T22(k)*G21r(n_q-i+1,n_q-j+1,k);
            
            A22r(i,j,k) = G21r(i,j,k)*T11(k)*G12r(n_q-i+1,n_q-j+1,k)... 
                        + G21r(i,j,k)*T12(k)*G22r(n_q-i+1,n_q-j+1,k)...
                        + G22r(i,j,k)*T21(k)*G12r(n_q-i+1,n_q-j+1,k)... 
                        + G22r(i,j,k)*T22(k)*G22r(n_q-i+1,n_q-j+1,k);
        end
    end
end


end

