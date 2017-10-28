% Script to generate T-matrix training examples
tic
filename='testexamples2.mat';

n_examples=5000;

n_q=501;
n_E=21;
E=0.09;


%INPUT: k points in units of 1/a, n_k has to be odd
%E in eV, E runs from -E to +E for n_E points, n_E has to be odd
tic
[qx,qy] = meshgrid(linspace(-1,1,n_q));
Epoints = linspace(-E,E,n_E);%converting in eV
I = eye(2);
Vs = 0.1;
Vm = 0.0;
d=0.01;
res=101;

[ E_tb ] = parabolic_band( qx,qy );


% Check if data file exists. If not, create it.
n_px=res^2;

if exist(filename, 'file') 
    
    load(filename);
    
    sumsquare=sum(examples.^2,1);
    n=find(sumsquare==0,1,'first');
    
else
    
    examples=zeros(n_px*n_E,n_examples);
    E_k=zeros(n_px*n_E,n_examples);
    labels=ones(n_examples,1);
    gap_harmonics=zeros(4,n_examples);
    save(filename,'examples','labels','gap_harmonics','-v7.3');
    n=0;
    
end


%m = matfile(filename, 'Writable', true);



iter=n_examples-n;
delete(gcp)
poolobj=parpool('local',4);

tic
parfor i=1:iter
% 
%     %n=n+1;
%     % calculate gap function
    D0 = 0.03;
    %[ D ] = gap_function( qx,qy,D0 );
    [ D, coeffs ] = random_swave_gap( qx,qy,D0,3 );
    %[ D,coeffs ] = random_dwave_gap( qx,qy,D0,3); 
    gap_harmonics(:,i+n)=coeffs;
    
    
    [ dnqUnwrap ,dispersion ] = calcQPI( E_tb,D,Epoints,d,Vs,Vm,res );
    
    examples(:,i+n)=dnqUnwrap;
    E_k(:,i+n)=dispersion;
    %labels(iter)=1;

    
    
    
end
 save(filename,'examples','labels','gap_harmonics','-v7.3');
 toc
 delete(poolobj)
  
  exit

