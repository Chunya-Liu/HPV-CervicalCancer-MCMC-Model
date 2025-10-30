function [fy,fx,Mean]= modelCI(day,X)
for i=1:length(day)
b=mean(X(i,:)); % 计算均值
a1=sort(X(i,:)); % 排序
b_ci=[a1(length(a1)*0.025); a1(length(a1)*0.975)]; % 计算2.5%和97.5%的分位点，即95%置信区间
%sigma_b=std(X(i,:));
%b_ci=[b-1.96*sigma_b; b+1.96*sigma_b];
Mean(i)=b;
meanci(:,i)=b_ci;
end
f=zeros(length(Mean),2);
i=1;
for t = 1:1:length(day);
f(i,1)=max([meanci(1,i),meanci(2,i)]); 
f(i,2)=min([meanci(1,i),meanci(2,i)]);
i=i+1;
end
t = 1:1:length(day);
fy=cat(2,f(:,1)',flipdim(f(:,2),1)')';
fx=cat(2,t,flipdim(t',1)')';