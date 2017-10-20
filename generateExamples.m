% Script to generate T-matrix training examples
tic
filename='testexamples2.mat';

n_examples=5;

n_q=501;
n_E=21;
E=0.1;


%INPUT: k points in units of 1/a, n_k has to be odd
%E in eV, E runs from -E to +E for n_E points, n_E has to be odd
tic
[qx,qy] = meshgrid(linspace(-1,1,n_q));
Epoints = linspace(-E,E,n_E);%converting in eV
I = eye(2);
Vs = 0.1;
Vm = 0.0;
d=0.01;

[ E_tb ] = parabolic_band( qx,qy );


% Check if data file exists. If not, create it.

if exist(filename, 'file') 
    
    load(filename);
    
    sumsquare=sum(examples.^2,1);
    n=find(sumsquare==0,1,'first');
    
else
 
    examples=zeros(2*n_q*n_q*n_E,n_examples);
    labels=zeros(n_examples,1);
    save(filename,'examples','labels','-v7.3');
    n=0;
    
end


m = matfile(filename, 'Writable', true);


iter=n_examples-n;
% poolobj=parpool('local',4);
tic
 for i=1:iter
% 
%     %n=n+1;
%     % calculate gap function
    D0 = 0.03;
    %[ D ] = gap_function( qx,qy,D0 );
     [ D ] = random_swave_gap( qx,qy,D0,2 );
    %[ D ] = random_dwave_gap( qx,qy,D0,2); 
    
    [ dnqUnwrap ,dispersion ] = calcQPI( E_tb,D,Epoints,d,Vs,Vm );
  
    examples(:,i+n)=dnqUnwrap;
    %labels(iter)=1;

    
    
    
 end
 toc
%  delete(poolobj)

