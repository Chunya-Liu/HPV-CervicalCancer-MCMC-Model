function dx= algaesys(t,x,k)
dx=zeros(7,1);
mu=1/79.43; 
Lambda=3215701;
N=492455274;
eta=k(1);
omega=k(2);
u=k(3);
beta_1=k(4);
beta_2=k(5);
sigma=k(6);
theta1=k(7);
phi=k(8);
epsilon=k(9);
tau=k(10);
d=k(11);

V=x(1); S=x(2); I_u=x(3); P=x(4); C=x(5); R=x(6); D=x(7);
N=x(1)+x(2)+x(3)+x(4)+x(5)+x(6)+x(7);

dx(1)=u*Lambda+eta*S-(omega+mu)*V;
dx(2)=(1-u)*Lambda+omega*V-S*(beta_1*I_u+beta_2*P)/N-(eta+mu)*S;
dx(3)=S*(beta_1*I_u+beta_2*P)/N-(theta1+mu)*I_u;
dx(4)=theta1*phi*I_u-(epsilon+tau+mu)*P;
dx(5)=theta1*sigma*I_u+tau*P-(d+mu)*C;
dx(6)=theta1*(1-phi-sigma)*I_u+epsilon*P-mu*R;
dx(7)=d*C;