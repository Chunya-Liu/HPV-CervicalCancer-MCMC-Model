function dx= algaesys(t,x,k)
dx=zeros(6,1);
mu=1/70.47; 
Lambda=5323349;
beta_1=k(1);
beta_2=k(2);
sigma=k(3);
theta1=k(4);
phi=k(5);
epsilon=k(6);
tau=k(7);
d=k(8);

S=x(1); I_u=x(2); P=x(3); C=x(4); R=x(5); D=x(6);
N=x(1)+x(2)+x(3)+x(4)+x(5)+x(6);

dx(1)=Lambda-S*(beta_1*I_u+beta_2*P)/N-(mu)*S;
dx(2)=S*(beta_1*I_u+beta_2*P)/N-(theta1+mu)*I_u;
dx(3)=theta1*phi*I_u-(epsilon+tau+mu)*P;
dx(4)=theta1*sigma*I_u+tau*P-(d+mu)*C;
dx(5)=theta1*(1-phi-sigma)*I_u+epsilon*P-mu*R;
dx(6)=d*C;