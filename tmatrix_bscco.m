function [out1,out2] = tmatrix_bscco(n_q,E,n_E)
%INPUT: k points in units of 1/a, n_k has to be odd
%E in eV, E runs from -E to +E for n_E points, n_E has to be odd
tic
[qx,qy] = meshgrid(linspace(-1,1,n_q));
Epoints = linspace(-E,E,n_E);%converting in eV
I = eye(2);
Vs = 0.1;
Vm = 0.0;
d=0.01;

%calculate TB model energies as per Wang and Lee QPI PRB, who used Norman
% [ E_tb] = cuprate_dispersion( qx,qy );
[ E_tb ] = parabolic_band( qx,qy );

% calculate gap function
D0 = 0.03;
%[ D ] = gap_function( qx,qy,D0 );
% [ D ] = random_swave_gap( qx,qy,D0,2 );
[ D ] = random_dwave_gap( qx,qy,D0,3); 
figure
imagesc(D)
axis square
colorbar;
caxis([-D0 D0]);
%calculate Green's function (2x2 matrix) for each k and E value

[ G11,G12,G11r,G12r, ...
  G21,G22,G21r,G22r ] = calcGreensFunction( E_tb,D,Epoints,d );

toc

%calculate T matrix
[ T11,T12,T21,T22 ] = calculateTMatrix( G11r,G12r,G21r,G22r,Vs,Vm );
toc

%calculate A
[ A11r, A22r ] = calculateSpectralFunction( G11r,G12r,G21r,G22r,T11,T12,T21,T22);
toc

cpix=(n_q+1)/2;
%calculate dn, change in density of states
[ dnr ] = deltaDOS( A11r, A22r );

spectrum=-imag(G11r(cpix,cpix,:)+G22r(cpix,cpix,:));
figure
plot(Epoints,squeeze(spectrum),'xk');
nr=repmat(spectrum,n_q, n_q, 1);

out1 = fftshift(fftshift(abs(fft2(dnr)),1),2);
out2 = -imag(G11);
toc