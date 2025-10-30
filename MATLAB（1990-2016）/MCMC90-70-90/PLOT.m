figure(1)
subplot(2,1,1); 
H_F1=fill(fx1,fy1,[0.8 0.8 0.8]);
set(H_F1,{'LineStyle'},{'none'});
hold on
plot(year,Mean1,'k','LineWidth',1.2)
hold on
plot(data(:,1),data(:,2),'.','color','r','markersize',10);
%%%%%%%%%%%%%%%
xlabel('Time (years)')
ylabel('Number of New CC Cases')
set(gca,'xtick',[1:2:28]);
set(gca,'xticklabel',{'1990','1992','1994','1996','1998','2000','2002','2004','2006','2008','2010','2012','2014','2016'});
set(gca,'FontSize',10,'LineWidth',1)
legend('95% CI','Estimated cases','Actual cases','location','NorthWest')
legend boxoff
% axis([1 27 0.3*10^5 2*10^5]);
xlim([1 27])

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
set(gca,'xtick',[1:2:28]);
set(gca,'xticklabel',{'1990','1992','1994','1996','1998','2000','2002','2004','2006','2008','2010','2012','2014','2016'});
 set(gca,'FontSize',10,'LineWidth',1)
 legend('95% CI','Estimated cases','Actual cases','location','NorthWest')
 legend boxoff
xlim([1 27])
% % box off
title('B')
