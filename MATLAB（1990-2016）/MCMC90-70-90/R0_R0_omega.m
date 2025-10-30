%%
mu=1/70.47; 
Lambda=5323349;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
R0_value=zeros(length(chain(nsimu1:nsimu,:)),1);

R0_beta_1=chain(nsimu1:nsimu,1);
R0_beta_2=chain(nsimu1:nsimu,2);
R0_sigma=chain(nsimu1:nsimu,3);
R0_theta=chain(nsimu1:nsimu,4);
R0_phi=chain(nsimu1:nsimu,5);
R0_epsilon=chain(nsimu1:nsimu,6);
R0_tau=chain(nsimu1:nsimu,7);
R0_d=chain(nsimu1:nsimu,8);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:length(chain(nsimu1:nsimu,:))

R01(i)=R0_beta_1(i)/(R0_theta(i)+mu);
R02(i)=(R0_beta_2(i)*R0_theta(i)*R0_phi(i))/((R0_theta(i)+mu)*(R0_epsilon(i)+R0_tau(i)+mu));

R01_value(i,1)=R01(i);
R02_value(i,1)=R02(i);
R0_value(i,1)=R01(i)+R02(i);

end
%%%%%%%%%%%%%%%%%%%%%%%%%% R0 %%%%%%%%%%%%%%%%%%%%%%%%%
R0_t=1:1:length(R0_value);
R0_mean=mean(R0_value);
R0_std=std(R0_value);
R0_CI=[R0_mean-R0_std; R0_mean+R0_std];
R0_mean=R0_mean+R0_t*0;
%%
%%%%%%%%%%%%%%% R0 %%%%%%%%%%%%%%%%%%%%%%%%%
figure(2)
subplot(2,2,1:2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%
x_R0=[0 R0_CI(1,1); 10000 R0_CI(1,1); 10000 R0_CI(2,1); 0 R0_CI(2,1)];
f_R0 = [1 2 3 4];
F_R0=patch('Faces',f_R0,'Vertices',x_R0,'FaceColor',[1.00,0.80,0.80],'FaceAlpha',0.9);
set(F_R0,'LineStyle','none')
hold on
sz=5;
p2 = scatter(R0_t, R0_value, sz, [0.3,0.6,0.9], 'filled');
hold on
p3=plot(R0_t,R0_mean,'Color', [1.00,0.07,0.65],'LineWidth',1);
hold on
legend([p3,F_R0,p2],'R_0 mean =  ','95% CI  ','R_0  ','orientation','horizon','location','NorthWest')
legend boxoff
xlabel('Sampling times')
ylabel('{R_0}')
set(gca,'FontSize',10,'LineWidth',1)
box on
title('A')
%%%%%%%%%%%%%%%%%%%%%%%%%% R0 %%%%%%%%%%%%%%%%%%%%%%%%%
R0_t1=1:1:length(R01_value);

[fy8,fx8,Mean8]= modelCI(1,R01_value');
R0_mean1=Mean8;
R0_CI1=[fy8,fx8];

R0_mean1=R0_mean1+R0_t1*0;
%%
%%%%%%%%%%%%%%% R0 %%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,2,3)
x_R0=[0 R0_CI1(1,1); 10000 R0_CI1(1,1); 10000 R0_CI1(2,1); 0 R0_CI1(2,1)];
f_R0 = [1 2 3 4];
F_R0=patch('Faces',f_R0,'Vertices',x_R0,'FaceColor',[1.00,0.80,0.80],'FaceAlpha',0.9);
set(F_R0,'LineStyle','none')
hold on
%%%%%%%%%%%%%%%%%%%%%%%%%%%
sz=5;
scatter(R0_t1,R01_value,sz, [0.3,0.6,0.9], 'filled')
hold on
p1=plot(R0_t1,R0_mean1,'Color', [1.00,0.07,0.65],'LineWidth',1.2);
hold on
 legend(p1,'R_{I_u} mean =  ','orientation','horizon','location','NorthWest')
legend boxoff
xlabel('Sampling times')
ylabel('{R_{I_u}}')
set(gca,'FontSize',10,'LineWidth',1)
box on
title('B')
R0_t2=1:1:length(R02_value);

R0_mean2=mean(R02_value);
R0_std2=std(R02_value);
R0_CI2=[R0_mean2-R0_std2; R0_mean2+R0_std2];

R0_mean2=R0_mean2+R0_t2*0;
%%
%%%%%%%%%%%%%%% R0 %%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,2,4)
%%%%%%%%%%%%%%%%%%%%%%%%%%%
x_R0=[0 R0_CI2(1,1); 10000 R0_CI2(1,1); 10000 R0_CI2(2,1); 0 R0_CI2(2,1)];
f_R0 = [1 2 3 4];
F_R0=patch('Faces',f_R0,'Vertices',x_R0,'FaceColor',[1.00,0.80,0.80],'FaceAlpha',0.9);
set(F_R0,'LineStyle','none')
hold on
sz=5;
scatter(R0_t2,R02_value,sz, [0.3,0.6,0.9], 'filled')
hold on
p1=plot(R0_t2,R0_mean2,'Color', [1.00,0.07,0.65],'LineWidth',1.2);
hold on
legend(p1,'R_{P} mean =  ','orientation','horizon','location','NorthWest')
legend boxoff
xlabel('Sampling times')
ylabel('{R_{P}}')
set(gca,'FontSize',10,'LineWidth',1)
box on
title('C')

%%
figure(3)

[R_b, P_b] = corr(R0_theta, R0_value);
[R_h, P_h] = corr(R0_theta, R01_value);
[R_a, P_a] = corr(R0_theta, R02_value);

subplot(2,2,1:2)
h = scatter(R0_theta, R0_value, 8, 'filled');   
h.MarkerEdgeColor = [1.00, 0.80, 0.80];         
h.MarkerFaceColor = [1.00, 0.80, 0.80]; 

xlabel('\theta');
ylabel('R_{0}');
title(sprintf('Correlation between \\theta and R_{0}: r=%.4f (p<0.01)', R_b));
set(gca, 'FontSize', 10, 'LineWidth', 1)
box on;
grid off;


subplot(2,2,3)
scatter(R0_theta, R01_value,8, [1.00,0.80,0.80], 'filled');
xlabel('\theta');
ylabel('R_{I_u}');
title(sprintf('Cor. (\\theta, R_{I_u}): r=%.4f (p<0.01)', R_h));
set(gca, 'FontSize', 10, 'LineWidth', 1)
box on;
grid off;

subplot(2,2,4)
scatter(R0_theta, R02_value,10, [1.00,0.80,0.80], 'filled');
xlabel('\theta');
ylabel('R_{P}');
title(sprintf('Cor. (\\theta, R_{P}): r=%.4f (p<0.01)', R_a));
set(gca, 'FontSize', 10, 'LineWidth', 1)
box on;
grid off;

