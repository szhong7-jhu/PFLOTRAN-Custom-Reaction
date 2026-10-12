%extract concentration from .csv and plot consider reoxygenation
% input flux = 0.05 m/yr
clear all
close all
De=1e-9;
iniA=1e-3;
iniB=1;
kw=1e-14;
REFR=[];%reaction front of B
REFR2=[];%reaction front of A
step=25;%50
TIME=0:step:7*step; %0:step:19*step
% len=-150:0.06:-0.06;
depth=-400:0.4:-0.4;
Z=0.5:0.5:1010;
X=0.4:0.4:400;
dx=0.5;
STREAM=[];
COXY=[];
Rate=[];
Velocity=[];
CORE=[];
P=[];
core=[150 1000 1800];
for j = 1:1000
    CORE=[CORE;core];
    core=core+2020;
end


WF=[];
wf1=[1624081:1624380]';
wf2=[];
wf3=[581589:581740]';
for m = 0:515
    point=[(803-m)*2020+301+3*m:(803-m)*2020+303+3*m];
    wf2=[wf2;point'];
end
WF=[wf1;wf2;wf3];

 for i=0:6
    % for i = 1: length(t)
    %     time=string(t(i));
    time= string(i);
    OXY=[];
    vx=[];
    vz=[];
    Drill=[];
    pre=[];
    Fe2=[];
    Fe3=[];
name='conc55555_';
back='.csv';
file=append(name,time,back);
M = readmatrix(file);
vx=M(1:end,4);
vz=M(1:end,6);
P=M(1:end,2);
V=sqrt(vx.^2+vz.^2);
Vec=reshape(V,2020,1000);
Vec=Vec';
% Veclog=real(log10(Vec'));
a=M(1:end,11);
b=M(1:end,12);
Fe2=reshape(a,2020,1000);
Fe2(Fe2==0)=nan;
Fe2=Fe2';
Fe3=reshape(b,2020,1000);
Fe3(Fe3==0)=nan;
Fe3=Fe3';
% a(a<1e-14)=0;
% H=TotFe + sqrt (TotFe**2 + 1.d-14)
H=M(1:end,13);
so4=M(1:end,14);
SO=reshape(96*1000.*so4,2020,1000);
% SO(SO<2e-9)=0;
% SO(SO>32)=36;
SO(SO==0)=nan;
SO=SO';
% SO=real(log10(SO'));
% OXY=M(2:end,9);
OXY= M(1:end,10);%SO4: 2.*M(:,10).*96
oxy=reshape(OXY,2020,1000);
oxy(oxy==0)=nan;
oxy(oxy<1e-6)=1e-8;
% oxy(oxy>2.7e-4)=0;

oxy=oxy';
% % oxy=real(log10(oxy'));
pre=reshape(P,2020,1000);
pre(pre<1e-18)=0;
pre=real(log10(pre'));

rate=-M(1:end,8);
% rate(rate<1e-12)=0;
% rate(rate==0)=nan;
% Rate=[Rate;rate(119701)];
Rate=reshape(rate,2020,1000);
Rate=real(log10(Rate'));
% Rate=Rate';

numerator=0;
denominator=0;
Velocity=[Velocity,V(1011200)];
for j = 601940:601960
    numerator=96*1000.*V(j)*so4(j)*dx+numerator;%/2.25e-4
%     numerator=V(j)*OXY(j)*dx./2.25e-4+numerator;
    denominator=V(j)*dx+denominator;%
end
Stream=numerator/denominator;
STREAM=[STREAM;Stream];

numerator2=0;
denominator2=0;
for k = 1:2000
    numerator2 = V(WF(k))* OXY(WF(k))*dx+numerator2;
    denominator2=V(WF(k))*dx+denominator2;
end
Coxy=numerator2/denominator2;
COXY=[COXY;Coxy];
%     TotA(TotA>iniA)=iniA;

%     F=find(TotA==0,1);
%     refr2=len(F);
%     REFR2=[REFR2;refr2];
%     if  i==13||i==15|| i ==13 || i ==19|| i ==50
%         figure
%         contourf(Z,X,SO)%,
%         title('SO4 profile')
%         set(gcf,'Position',[500 500 1000 400]);
%         colorbar
%     end
% plot(2*96*1000.*a(CORE(:,1)),depth,2*96*1000.*a(CORE(:,2)),depth,2*96*1000.*a(CORE(:,3)),depth)
% plot(OXY(CORE(:,1))./2.65e-4,depth,OXY(CORE(:,2))./2.65e-4,depth,OXY(CORE(:,3))./2.65e-4,depth)
% plot(OXY(CORE(:,1))./2.65e-4,depth,OXY(CORE(:,2))./2.65e-4,depth,OXY(CORE(:,3))./2.65e-4,depth)
%             Drill=[Drill;rate(CORE(k))];
%         end
%         figure
%         plot(Drill,depth)
%     end

 end
% Color-blind-friendly diverging colormap
ncol = 256;
cmap_WRR = interp1([0 0.5 1], ...
    [0.20 0.45 0.70; ...
     0.96 0.96 0.96; ...
     0.85 0.37 0.08], ...
    linspace(0,1,ncol),'linear');
% figure
%  plot(pre(CORE(:,1)),depth,pre(CORE(:,2)),depth,pre(CORE(:,3)),depth)
 figure
 contourf(Z,X,Rate)
%  contourf(Z,X,oxy./2.6e-4)
%  title('oxy profile')
 set(gcf,'Position',[500 500 1000 400]);
 colorbar
 set(gca,'CLim',[-12 -9.5]);
 colormap(jet)
colormap(gca,cmap_WRR);
set(gca,'FontName','Arial','FontSize',11,'LineWidth',1,'Box','on');
set(gcf,'Color','w');
colorbar; 
cb = colorbar;

% figure 
% plot(TIME,Velocity)
% title('velocity at x=600 y=200 through time(day)')
figure 
plot(TIME,STREAM)
title('stream SO4 concentration through time(yr)')
% title('Stream SO4 profile versus time')
figure
contourf(Z,X,SO)%,
% title('SO4 profile')
set(gcf,'Position',[500 500 1000 400]);
colorbar
      set(gca,'CLim',[0 120]);
%   set(gca,'CLim',[0 45]);
% figure
% contourf(Z,X,oxy)%,
% title('oxygen profile')
% colorbar
% figure
% contourf(Z,X,pre)%,
% title('Fe+++ precipitation rate profile')
% set(gcf,'Position',[500 500 1000 400]);
% colorbar
% figure
% contourf(Z,X,pre)%,
% title('pressureprofile')
% set(gcf,'Position',[500 500 1000 400]);
% colorbar

%  figure
%  plot(OXY(CORE(:,1))./2.65e-4,depth,OXY(CORE(:,2))./2.65e-4,depth,OXY(CORE(:,3))./2.65e-4,depth)
%  title('oxy profile')
augdo=[1;0.26;0.27;0.13;0.11;0.08;0.04;0;0;0];
augde=-[0;45;61;76;84;91;93;94;95;150];
sepdo=[1;0.62;0.62;0.55;0.55;0.51;0.49;0.41;0.33;0.33;0.3;0.32;0.04;0;0];
sepde=-[0;38;44;50;56;62;68;74;80;86;92;98;102;103;150];
jundo=[1;0.66;0.25;0.16;0.16;0.14;0.12;0.12;0.12;0.1;0;0;0];
junde=-[0;36;45;55;64;73;82;91;100;110;116;119;150];
% hold on
% plot(jundo,junde,'--kp',augdo,augde,'--rs',sepdo,sepde,'--bo')
% legend('Modelled oxygen profile at the ridge','at the middle','near stream','Measured Jun19,2012','Measured Aug25,2011','Measured Sep20,2011')
% plot(augdo,augde,'--rs')
% % legend('Modelled oxygen profile at the ridge','at the middle','near stream','Measured oxygen on Aug 25th,2011')
% 
%  figure
%  
 meanso=[95;106;93;95;96;110];
 meande=[-101;-103;-117;-124;-130;-150];
%  plot(2*96*1000.*a(CORE(:,1)),depth,2*96*1000.*a(CORE(:,2)),depth,2*96*1000.*a(CORE(:,3)),depth,meanso,meande,'rs')
%  title('SO4 profile')
%  legend('Modelled SO4 profile at the ridge','at the middle','near stream','Mean SO4 at the ridge')


% xlabel('DO(%Saturation)')
% ylabel('Depth(m)')
% % plot recharge-WT-SO4
% t = tiledlayout(1,1);
% ax1 = axes(t);
% plot(ax1,recharge,WT,'-r')
% ax1.XColor = 'r';
% ax1.YColor = 'r';
% ax2 = axes(t);
% plot(ax2,SO4,WT,'-k')
% ax2.XAxisLocation = 'top';
% ax2.YAxisLocation = 'right';
% ax2.Color = 'none';
% ax1.Box = 'off';
% ax2.Box = 'off';
% ylabel('water table depth')
% xlabel(ax1, 'recharge rate');
% xlabel(ax2, 'stream SO4 concentration');
% 
r=[0.2;0.5]; 
wt=[153.5;100];
r2=[0.2;0.3;0.5];
so=[103;52;28]; 
% yyaxis left 
% plot(r,wt,'--')
% xlabel('recharge rate') 
% ylabel('water table depth') 
% yyaxis right
% plot(r2,so) 
% ylabel('stream SO4 concentration')
% 

 x=[0;200;400;600;800;1000;1200];
height=[3687;3617;3550;3514;3460;3434;3414];
set(gcf,'Position',[500 500 1000 400]);
% plot(x,height,'black')
% ylim([3300,3700])

%%%dO2 baseline plot
% time= string(6);
% Z=0.5:0.5:1010;
% X=0.4:0.4:400;
%     OXY=[];
%     vx=[];
%     vz=[];
%     Drill=[];
%     pre=[];
%     Fe2=[];
%     Fe3=[];
% name='conc2_';
% back='.csv';
% file=append(name,time,back);
% M = readmatrix(file);
% name2='conc5_';
% time2= string(5);
% file2=append(name2,time2,back);
% M2 = readmatrix(file2);
% OXY= M(1:end,10);%SO4: 2.*M(:,10).*96
% oxy=reshape(OXY,2020,1000);
% oxy=oxy';
% OXY2= M2(1:end,10);%SO4: 2.*M(:,10).*96
% oxy2=reshape(OXY2,2020,1000);
% oxy2=oxy2';
% oxy(oxy==0)=nan;
% oxy(oxy<1e-6)=1e-8;
% oxy2(oxy2==0)=nan;
% oxy2(oxy2<1e-6)=1e-8;
% diff=oxy-oxy2;
% diff(diff<=0)=nan;


%         plot(OXY(CORE(:,1))./2.25e-4,depth,OXY(CORE(:,2))./2.25e-4,depth,OXY(CORE(:,3))./2.25e-4,depth)


%     figure
%     contourf(xlen,zlen,vf)
%     colorbar()
%           hold on 
%           plot(i/10,Stream/2.25e-4,'o')
%           plot(OXY(119890)/2.25e-4,'o')
%           plot(SAT./saturated,len)figure

%     end    
  
    % contourf(log10(tota))
    % colorbar()
% legend('t=40','t=55','t=100','t=150','t=170','t=240')
%Data from Manning's paper Fig 14b
% figure
% time=0.5:0.5:49*0.5;
% plot(time,STREAM)
% xlabel('time')
% ylabel('SO4 (mg/L) verse depth')
% ylabel('oxygen saturation')
% plot(time,Rate)


% figure
% % plot(a(CORE(:,1)))
% % hold on
% % plot(a(CORE(:,2)))
% % plot(a(CORE(:,3)))
% plot(2*96*1000.*a(CORE(:,1)),depth,2*96*1000.*a(CORE(:,2)),depth,2*96*1000.*a(CORE(:,3)),depth)
% xlabel('SO4 (mg/L) verse depth')
% ylabel('depth/m')
% legend('on the ridge','at the middle','near stream')
% figure
% plot(OXY(CORE(:,1))./2.25e-4,depth,OXY(CORE(:,2))./2.25e-4,depth,OXY(CORE(:,3))./2.25e-4,depth)
% xlabel('oxygen saturation verse depth')
% ylabel('depth/m')
% legend('on the ridge','at the middle','near stream')
% figure
% plot(rate(CORE(:,1)),depth,rate(CORE(:,2)),depth,rate(CORE(:,3)),depth)

% subplot(1,3,1)
% plot(SAT./12.25e-4,len)%O2
% title('oxygen saturation versus depth')
% subplot(1,3,2)
% plot(2.5.*TotF.*1000*96,len)%SO4 
% title('SO4 (mg/L) versus depth')
% subplot(1,3,3)
% plot(-log10(TotH),len)%pH
% title('pH versus depth')
% % a simple script for an advective system
% % clear all
% % close all
% % Da is Damkohler number, ratio of reaction time scale to travel time
% % along flow path for the initial condition (i.e. fresh mineral all long
% % the flow path)
% % eps is a molar density ratio, i.e. how much is
% % the mineral volume fraction altered by the aqueous reaction.  It is
% % related to the ratio of solubility to mineral molar density in the
% % solid phase (typically a small quantity), hence "eps"
% % dzet=0.001;Da=200;m=1;eps=1e-3;nt=1000;
% % zet=0:dzet:1;nzet=length(zet);
% % initialize g and b
% % g is dimensionless concentration - C/C_solubility, solution assume to
% % enter fresh (g = 0) at the inflow, also initially 1 everywhere
% % b is a dimensionless mineral fraction, initially 1 everywhere (fresh rock)
% % f is a transformation of b, to account for the dependence of reactive
% % surface area per unit volume on b.  I am using m = 1 in the base case, but
% % it gets interesting for higher values of m (steeper drop of reactive
% % surface area as mineral is consumed - "intrinsic mechanisms")
% % g=ones(nzet,1);b=ones(nzet,1);
% % solve for the quasi-steady state concentration field in the first
% % time-step
% % g(1)=0;
% % f=b.^m;
% % this is from a backwards-difference for stable calculation
% % update concentration
% % for j=2:nzet
% %     g(j)=(g(j-1)+Da*f(j)*dzet)/(1+Da*f(j)*dzet);
% % end
% % start time loop
% % for it=1:nt
% %     solve for the quasi-steady state concentration field
% %     f=b.^m;
% %     react=Da.*f.*(1-g);
% %     update concentration
% %     g=cumsum(react*dzet);
% %     g(g>1)=1;g(g<0)=0;
% %     update mineral volume fraction
% %     b=b-eps*Da.*f.*(1-g);
% %     react is the weathering rate profile
% %     maxr=max(react);
% %     here I am plotting 1-g and b versus distance
% %     subplot(1,2,1)
% %     plot(1-g,1-zet,b,1-zet)
% %     ylim([0 1])
% %     now plotting reaction rate
% %     subplot(1,2,2)
% %     plot(react,1-zet)
% %     xlim([0 50])
% %     pause(0.0001)
% %     sumreact is the spatially integrated reaction rate = total weathering
% %     rate
% %     sumreact(it)=trapz(zet,react)*dzet;
% % end
% % figure
% % this is to understand time-dependence
% % plot(log10(sumreact))
% %         