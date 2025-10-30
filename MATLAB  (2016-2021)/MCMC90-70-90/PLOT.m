figure(1)
subplot(2,1,1); %在该图形窗口中创建一个1x2的子图，并将当前轴设置为该子图中的第1个轴。
H_F1=fill(fx1,fy1,[0.8 0.8 0.8]);%创建一个填充区域，填充颜色为灰色（RGB值为[0.8 0.8 0.8]）。fx1和fy1是用于定义填充区域形状的点的x和y坐标向量。
set(H_F1,{'LineStyle'},{'none'});%将填充区域的边线样式设置为无边线。
hold on
plot(year,Mean1,'k','LineWidth',1.2)
hold on
plot(data(:,1),data(:,2),'.','color','r','markersize',10);
%%%%%%%%%%%%%%%
xlabel('Time (years)')
ylabel('Number of New CC Cases')
set(gca,'xtick',[1:2:6]);
set(gca,'xticklabel',{'2016','2018','2020'});
set(gca,'FontSize',10,'LineWidth',1)
legend('95% CI','Estimated cases','Actual cases','location','NorthWest')
legend boxoff
axis([1 6 0.3*10^5 2*10^5]);
% box off
title('A')



subplot(2,1,2); 
H_F2=fill(fx2,fy2,[0.8 0.8 0.8]);
set(H_F2,{'LineStyle'},{'none'});
hold on
plot(year,Mean2,'k','LineWidth',1.2)
hold on
plot(data(:,1),data(:,3),'.','color','b','markersize',10);
%%%%%%%%%%%%%%%
xlabel('Time (years)')
ylabel('Number of CC Deaths')
set(gca,'xtick',[1:2:6]);
set(gca,'xticklabel',{'2016','2018','2020'});
 set(gca,'FontSize',10,'LineWidth',1)
 legend('95% CI','Estimated cases','Actual cases','location','NorthWest')
 legend boxoff
% axis([1 6 2*10^4 4*10^4]);
% % box off
title('B')
