load all.mat

[fy1,fx1,Mean1]= modelCI(year,new_DI1);
[fy2,fx2,Mean2]= modelCI(year,new_DA1);

figure(1)
subplot(2,1,1); %在该图形窗口中创建一个1x2的子图，并将当前轴设置为该子图中的第1个轴。

H_F1=fill(fx1,fy1,[0.8 0.8 0.8]);%创建一个填充区域，填充颜色为灰色（RGB值为[0.8 0.8 0.8]）。fx1和fy1是用于定义填充区域形状的点的x和y坐标向量。
set(H_F1,{'LineStyle'},{'none'});%将填充区域的边线样式设置为无边线。
hold on
% H_F1=fill(fx11,fy11,[0.8 0.8 0.8]);%创建一个填充区域，填充颜色为灰色（RGB值为[0.8 0.8 0.8]）。fx1和fy1是用于定义填充区域形状的点的x和y坐标向量。
% set(H_F1,{'LineStyle'},{'none'});%将填充区域的边线样式设置为无边线。
% hold on

plot(year,Mean1,'k','LineWidth',1.2)
hold on
plot(data(:,1),data(:,2),'.','color','r','markersize',10);
hold on
plot([27 27],[0.3*10^5 2*10^5],'--','color','r','LineWidth',0.8)
%%%%%%%%%%%%%%%
xlabel('Time (years)')
ylabel('Number of New CC Cases')
set(gca,'xtick',[1:2:32]);
set(gca,'xticklabel',{'1990','1992','1994','1996','1998','2000','2002','2004','2006','2008','2010','2012','2014','2016','2018','2020'});
set(gca,'FontSize',10,'LineWidth',1)
legend('95% CI','Estimated cases','Actual cases','location','NorthWest')
legend boxoff
axis([1 32 0.1*10^5 2*10^5]);
% box off
title('A')
annotation('textarrow',[0.6846,0.7775],[0.8338,0.8138],'String',{'Get HPV vaccine'})



subplot(2,1,2); 
H_F2=fill(fx2,fy2,[0.8 0.8 0.8]);
set(H_F2,{'LineStyle'},{'none'});
hold on
% H_F2=fill(fx22,fy22,[0.8 0.8 0.8]);
% set(H_F2,{'LineStyle'},{'none'});
% hold on
plot(year,Mean2,'k','LineWidth',1.2)
hold on
plot(data(:,1),data(:,3),'.','color','b','markersize',10);
hold on
plot([27 27],[1.5*10^4 4*10^4],'--','color','b','LineWidth',0.8)

%%%%%%%%%%%%%%%
xlabel('Time (years)')
ylabel('Number of Cumulative CC Deaths')
set(gca,'xtick',[1:2:32]);
set(gca,'xticklabel',{'1990','1992','1994','1996','1998','2000','2002','2004','2006','2008','2010','2012','2014','2016','2018','2020'});
 set(gca,'FontSize',10,'LineWidth',1)
 plot([27 27],[0*10^5 20*10^5],'--','color','b','LineWidth',0.8)

 legend('95% CI','Estimated cases','Actual cases','location','NorthWest')
 legend boxoff
axis([1 32 0 11*10^5]);
% % box off
title('B')
annotation('textarrow',[0.688557142857142,0.781457142857142],[0.379,0.359],'String',{'Get HPV vaccine'})

