function [ G11,G12,G11r,G12r,G21,G22,G21r,G22r ] = calcGreensFunction( E_tb,D,Epoints,d )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

n_q=size(E_tb,1);
n_E=length(Epoints);

G11 = zeros(n_q,n_q,n_E);
G12 = zeros(n_q,n_q,n_E);
G21 = zeros(n_q,n_q,n_E);
G22 = zeros(n_q,n_q,n_E);
G11r = zeros(n_q,n_q,n_E);
G12r = zeros(n_q,n_q,n_E);
G22r= zeros(n_q,n_q,n_E);
G21r = zeros(n_q,n_q,n_E);

for k=1:n_E
    den = (Epoints(k)^2-E_tb.^2-D.^2-d^2+1i*2*Epoints(k)*d);
    G11(:,:,k) = (Epoints(k) + E_tb + 1i*d) ./den;
    G22(:,:,k) = (Epoints(k) - E_tb + 1i*d) ./den;
    G12(:,:,k) = D./den;
    G21(:,:,k) = G12(:,:,k);
    %get all G's in r-space for useful computations later
    G11r(:,:,k) = fftshift(fft2(G11(:,:,k)))/(n_q*n_q);
    G12r(:,:,k) = fftshift(fft2(G12(:,:,k)))/(n_q*n_q);
    G21r(:,:,k) = fftshift(fft2(G21(:,:,k)))/(n_q*n_q);
    G22r(:,:,k) = fftshift(fft2(G22(:,:,k)))/(n_q*n_q);
end

end

