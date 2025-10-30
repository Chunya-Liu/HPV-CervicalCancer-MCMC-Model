function ss = algaess(theta,data)
% algae sum-of-squares function
time   = data(:,1);
ydata1  = data(:,2);  %C
ydata2  = data(:,3);  %D
% N=369933901;
S0=theta(9);
I_u0=theta(10);
P0=theta(11);
C0=47051.60044;
D0=21881.75845;
R0=369933901-theta(9)-theta(10)-theta(11)-47051.60044;

y0 =[S0,I_u0,P0,C0,R0,D0]; %³õÖµ
[t,y] = ode45(@algaesys,time,y0,[],theta);

Y1=theta(3)*theta(4)*y(:,2)+theta(7)*y(:,3);
Y2=y(:,6);
% Y2=theta(8)*y(:,4);

ss1=sum((Y1-ydata1).^2);
ss2=sum((Y2-ydata2).^2);
ss=[ss1 ss2];


