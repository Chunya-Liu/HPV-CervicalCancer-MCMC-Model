function ss = algaess(theta,data)

time   = data(:,1);
ydata1  = data(:,2);  
ydata2  = data(:,3); 
V0=0;
S0=theta(12);
I_u0=theta(13);
P0=theta(14);
C0=9.9794e+04;
D0=661940.4855;
R0=1.3E6;


y0 =[V0,S0,I_u0,P0,C0,R0,D0];
[t,y] = ode45(@algaesys,time,y0,[],theta);

Y1=theta(6)*theta(7)*y(:,3)+theta(10)*y(:,4);
Y2=y(:,7);

ss1=sum((Y1-ydata1).^2);
ss2=sum((Y2-ydata2).^2);

ss=[ss1 ss2];


