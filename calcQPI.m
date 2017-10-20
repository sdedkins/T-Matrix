function [ dnqUnwrap ,dispersion ] = calcQPI( E_tb,D,Epoints,d,Vs,Vm )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here



[ G11,G12,G11r,G12r, ...
  G21,G22,G21r,G22r ] = calcGreensFunction( E_tb,D,Epoints,d );



%calculate T matrix
[ T11,T12,T21,T22 ] = calculateTMatrix( G11r,G12r,G21r,G22r,Vs,Vm );


%calculate A
[ A11r, A22r ] = calculateSpectralFunction( G11r,G12r,G21r,G22r,T11,T12,T21,T22);


%calculate dn, change in density of states
[ dnr ] = deltaDOS( A11r, A22r );

dnq = fftshift(fftshift(fft2(dnr),1),2);

dnqUnwrap=[ real(dnq(:)); imag(dnq(:))];
dispersion = -imag(G11(:));



% figure(99)
% subplot(2,2,1);
% imagesc(D)
% b=max(abs(D(:)));
% caxis([-b b]);
% axis equal
% subplot(2,2,2);
% imagesc(abs(dnq(:,:,1)))
% axis equal
% subplot(2,2,3);
% a=reshape(dnqUnwrap(1:length(dnqUnwrap)/2),size(dnq));
% imagesc(a(:,:,1));
% axis equal
% subplot(2,2,4);
% imagesc(imag(dnq(:,:,1)))
% axis equal
% 
% disp('Press a key !')
% pause;

end

