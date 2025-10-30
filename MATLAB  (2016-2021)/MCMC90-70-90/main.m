clc
clear
%%实际数据
A=xlsread('data.xlsx');
n=length(A);
DX2=A(:,2);
DX3=A(:,3);
year=[1:1:n]';%年
data=[year,DX2,DX3];


method   = 'dram'; % adaptation method, 'mh', 'dr', 'am', or 'dram'
nsimu    = 200000;   % number of simulations
nsimu1   = 190001;   % burn in
adaptint = 500;    % how often to adapt the proposal



model.S20 = 1;
model.N0  = 4;
options.method      = method;        % adaptation method (mh,am,dr,dram)
options.nsimu       = nsimu;         % n:o of simulations
%options.qcov        = eye(11)*1e-5; % proposal covariance 
options.adaptint    = adaptint; % adaptation interval 
options.printint    = 200; % how often to show info on acceptance ratios 
options.verbosity   = 1;  % how much to show output in Matlab window 
options.waitbar     = 1;  % show garphical waitbar
options.updatesigma = 1;  % update error variance 
options.stats       = 1;  % save extra statistics in results 

%%
% The model sum of squares in file <algaess.html |algaess.m|> is
% given in the model structure.
model.ssfun = @algaess;

%% 

k0=[0.00564424159666974
0.0425872444121893
0.451687135992020
0.217190663771207
0.610389783698649
0.274232031479064
0.316540811304097
0.668859543520109
0.912859064668768
0.159990717494921
0.111096007921862
391617252.782820
897320.937074671
138042.003441128];%
%% 
params = {
    {'\eta',k0(1),  0,1}      
    {'\omega',k0(2), 1/30,1/10} 
    {'u', k0(3),  0,1}
    {'\beta_1',   k0(4),  0,1}
    {'\beta_2',   k0(5),  0,1}
    {'\sigma',  k0(6),  1/20,1/3}   
    {'\theta',   k0(7),  0.1,0.5}
    {'\phi',   k0(8),  1/5,1/1}   
    {'\epsilon',   k0(9),  1/5,1/1} 
    {'\tau',   k0(10),  1/15,1/3}  
    {'d',   k0(11),  0,1}   
    {'S',   k0(12),  302455274,492455274}
    {'I_u',   k0(13),100000,	321964219.200000}    
    {'P',   k0(14),100000,	321964219.200000} 
    };%

%%
% First generate an initial chain.
results = [];
[results, chain, s2chain,sschain]=mcmcrun(model,data,params,options,results);



%%
% % Chain plots should reveal that the chain has converged and we can
% % use the results for estimation and predictive inference.

OUT=chainstats(chain(nsimu1:nsimu,:),results);
K=chain(nsimu1:nsimu,:);

ModelfunIC=zeros(length(year),length(chain(nsimu1:nsimu,:)));

for i=1:length(chain(nsimu1:nsimu,:))
V0=0;
S0=K(i,12);
I_u0=K(i,13);
P0=K(i,14);
C0=9.9794e+04;
D0=661940.4855;
R0=1.3E6;



[t3,y3] = ode45(@algaesys,year,[V0,S0,I_u0,P0,C0,R0,D0],[],K(i,:));

new_DI1(:,i)=k0(6)*k0(7)*y3(:,3)+k0(10)*y3(:,4);
new_DA1(:,i)=y3(:,7);


end

[fy1,fx1,Mean1]= modelCI(year,new_DI1);
[fy2,fx2,Mean2]= modelCI(year,new_DA1);


