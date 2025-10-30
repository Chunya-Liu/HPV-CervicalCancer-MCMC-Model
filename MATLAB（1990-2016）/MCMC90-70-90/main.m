clc
clear
%%
A=xlsread('data.xlsx');
n=length(A);
DX2=A(:,2);
DX3=A(:,3);
year=[1:1:n]';
data=[year,DX2,DX3];
%%


method   = 'dram'; % adaptation method, 'mh', 'dr', 'am', or 'dram'
nsimu    = 200000;   % number of simulations
nsimu1   = 190001;   % burn in
adaptint = 500;    % how often to adapt the proposal


% model.sigma2=0.01;
model.S20 = 1;
model.N0  = 4;
options.method      = method;        % adaptation method (mh,am,dr,dram)
options.nsimu       = nsimu;         % n:o of simulations
%options.qcov        = eye(11)*1e-5; % proposal covariance
options.adaptint    = adaptint; % adaptation interval 
options.printint    = 200; % how often to show info on acceptance ratios 
options.verbosity   = 1;  % how much to show output in Matlab window
options.waitbar     = 1; % show garphical waitbar
options.updatesigma = 1;  % update error variance 
options.stats       = 1;  % save extra statistics in results 

%%
% The model sum of squares in file <algaess.html |algaess.m|> is
% given in the model structure.
model.ssfun = @algaess;

%%

k0=[0.295027985495995
0.528702535253250
0.100759434875326
0.292160927483586
0.330241413219222
0.577506782836829
0.0992622415838276
0.0594417615929792
352069278.026835
1002151.78167298
249172.114428885];  %6


%%
params = {
    {'\beta_1',   k0(1),  0,1}
    {'\beta_2',   k0(2),  0,1}
    {'\sigma',  k0(3),  1/20,1/3} 
    {'\theta',   k0(4),  0.1,0.5}
    {'\phi',   k0(5),  1/5,1/1}  
    {'\epsilon',   k0(6),  1/5,1/1}  
    {'\tau',   k0(7),  1/15,1/3}    
    {'d',   k0(8), 0,1}     
    {'S',   k0(9),  300000000,369900000}
    {'I_u',   k0(10),500000,309933901*0.8}    
    {'P',   k0(11),100000,309933901*0.8}    
    };
%%
% First generate an initial chain.
results = [];
[results, chain, s2chain,sschain]=mcmcrun(model,data,params,options,results);


figure; clf
mcmcplot(chain,[],results,'chainpanel');
% figure; clf
% mcmcplot(chain,[],results,'hist',20)
%mcmcplot(chain,[],results,'pairs');
figure; clf
mcmcplot(chain,[],results,'denspanel',2);
%%
% % Chain plots should reveal that the chain has converged and we can
% % use the results for estimation and predictive inference.

OUT=chainstats(chain(nsimu1:nsimu,:),results);
K=chain(nsimu1:nsimu,:);

ModelfunIC=zeros(length(year),length(chain(nsimu1:nsimu,:)));

for i=1:length(chain(nsimu1:nsimu,:))
S0=K(i,9);
I_u0=K(i,10);
P0=K(i,11);
C0=47051.60044;
D0=21881.75845;
R0=369933901-k0(9)-k0(10)-k0(11)-47051.60044;


[t3,y3] = ode45(@algaesys,year,[S0,I_u0,P0,C0,R0,D0],[],K(i,:));

new_DI1(:,i)=k0(3)*k0(4)*y3(:,2)+k0(7)*y3(:,3);
new_DA1(:,i)=y3(:,6);



end

[fy1,fx1,Mean1]= modelCI(year,new_DI1);
[fy2,fx2,Mean2]= modelCI(year,new_DA1);



PLOT
R0_R0_omega
