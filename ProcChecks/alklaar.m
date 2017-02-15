z=repmat(0,51,136);

u=[10 20 24 28 30 34 38];
for i=1:length(u)
	z(:,i:7:112)=u(i);
end
u=[42 46 50];
for i=1:length(u)
	z(:,112+i:3:137)=u(i);
end

z(30:51,1:56)=0;
pcolor(z);hold on
axis equal
axis([-2 138 -2 53]);
cb=colorbar;set(get(cb,'title'),'string','U10 [m/s]');
set(gca,'xtick',[5:7:112,114:3:135],'xticklabel',[22.5:22.5:360 202.5:22.5:360]);
set(gca,'ytick',[1.5:1:51],'yticklabel',[-2:0.25:2.75, 2.99 3:0.5:6.5 0:0.25:2.75, 2.99 3:0.5:6.5],'fontsize',8)
plot([-5,141],[30 30],'k','linewidth',2);
ylabel(['          OSK OPEN                                        OSK DICHT']);
xlabel(['wind richting [^oN]']);
clim([0 50])
