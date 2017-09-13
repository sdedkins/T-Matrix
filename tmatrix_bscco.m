function [out1,out2] = tmatrix_bscco(n_q,E,n_E)
%INPUT: k points in units of 1/a, n_k has to be odd
%E in eV, E runs from -E to +E for n_E points, n_E has to be odd
tic
[qx,qy] = meshgrid(linspace(-1,1,n_q));
Epoints = linspace(-E,E,n_E);%converting in eV
I = eye(2);
Vs = 0.1;
Vm = 0.0;
d=0.0015;

%calculate TB model energies as per Wang and Lee QPI PRB, who used Norman
[ E_tb] = cuprate_dispersion( qx,qy );

% calculate gap function
D0 = 0.02;
[ D ] = gap_function( qx,qy,D0 );

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


%calculate dn, change in density of states
[ dnr ] = deltaDOS( A11r, A22r );

nr=-imag(G11r+G22r);

out1 = G11;
out2 = nr;
toc