function [ dnqUnwrap ,dispersion ] = calcQPI( E_tb,D,Epoints,d,Vs,Vm,res )
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

dnr_shift=ifftshift(ifftshift(dnr,1),2);

dnq = fftshift(fftshift(fft2(dnr_shift),1),2);

n_q=size(dnq,1);
mid_px=ceil(n_q/2);

small_dnq=real(dnq(1:mid_px,1:mid_px,:));


interp_points=linspace(1,mid_px,res);
real_points=linspace(1,mid_px,mid_px);

[Xq,Yq,Zq]=meshgrid(interp_points,interp_points,Epoints);
[X,Y,Z]=meshgrid(real_points,real_points,Epoints);

smaller_dispersion=interp3(X,Y,Z,-imag(G11(1:mid_px,1:mid_px,:)),Xq,Yq,Zq);
smaller_dnq=interp3(X,Y,Z,small_dnq,Xq,Yq,Zq);

% subtract mean and normalize

mu=mean(smaller_dnq(:));
range=max(smaller_dnq(:))-min(smaller_dnq(:));
smaller_dnq=(smaller_dnq-mu)/(0.5*range);


dnqUnwrap=smaller_dnq(:);
dispersion = smaller_dispersion(:);



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

