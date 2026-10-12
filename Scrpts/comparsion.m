%%dO2 baseline plot
close all
clear all

Z=0.5:0.5:1010;
X=0.4:0.4:400;
    OXY=[];
    vx=[];
    vz=[];
    Drill=[];
    pre=[];
    Fe2=[];
    Fe3=[];
time= string(6);
name='conc2_';
back='.csv';
file=append(name,time,back);
M = readmatrix(file);
name2='conc22_';
time2= string(6);
file2=append(name2,time2,back);
M2 = readmatrix(file2);
OXY= M(1:end,10);%SO4: 2.*M(:,10).*96
oxy=reshape(OXY,2020,1000);
oxy=oxy';
Fe3=M(1:end,12);
Fe3=reshape(Fe3,2020,1000);
Fe3(Fe3==0)=nan;
Fe3=Fe3';
so4=M(1:end,14);
SO=reshape(96*1000.*so4,2020,1000);
SO(SO==0)=nan;
SO=SO';
OXY2= M2(1:end,10);%SO4: 2.*M(:,10).*96
oxy2=reshape(OXY2,2020,1000);
oxy2=oxy2';
Fe3b=M2(1:end,12);
Fe3b=reshape(Fe3b,2020,1000);
Fe3b(Fe3b==0)=nan;
Fe3b=Fe3b';
so4b=M2(1:end,14);
SOb=reshape(96*1000.*so4b,2020,1000);
SOb(SOb==0)=nan;
SOb=SOb';
oxy(oxy==0)=nan;
oxy(oxy<1e-6)=1e-8;
oxy2(oxy2==0)=nan;
oxy2(oxy2<1e-6)=1e-8;
diff=oxy2-oxy;
% diff(diff<=0)=nan;
Osat= 2.6e-4;
difffe=Fe3b-Fe3;
% difffe(difffe<=-1e-9)=0;
diffso=SOb-SO;
% diffso(diffso>=0)=0;
% plot(OXY(CORE(:,1))./2.25e-4,depth,OXY(CORE(:,2))./2.25e-4,depth,OXY(CORE(:,3))./2.25e-4,depth)

% === ADDED FOR WRR / REVIEWER COMMENTS: preserve valid zero-change cells ===

% Reconstruct original O2 and SO4 values
oxy_raw  = reshape(M(:,10),2020,1000)';
oxy2_raw = reshape(M2(:,10),2020,1000)';

SO_raw   = reshape(96*1000.*M(:,14),2020,1000)';
SOb_raw  = reshape(96*1000.*M2(:,14),2020,1000)';

% Identify the model domain using sulfate
domainMask = ~isnan(SO) | ~isnan(SOb);

% Recalculate differences from original values
diff   = oxy2_raw - oxy_raw;
diffso = SOb_raw - SO_raw;
% diff(diff<=0)=0;
% Keep only cells outside the model domain as NaN
diff(~domainMask)   = NaN;
diffso(~domainMask) = NaN;

% Color-blind-friendly diverging colormap
ncol = 256;
cmap_WRR = interp1([0 0.5 1], ...
    [0.20 0.45 0.70; ...
     0.96 0.96 0.96; ...
     0.85 0.37 0.08], ...
    linspace(0,1,ncol),'linear');
figure
contourf(Z,X,diff)%./Osat

set(gcf,'Position',[500 500 1000 400]);
caxis([-2.2e-4, 2.2e-4]);
colormap(jet)
colormap(gca,cmap_WRR);
set(gca,'FontName','Arial','FontSize',11,'LineWidth',1,'Box','on');
set(gcf,'Color','w');
colorbar; 
cb = colorbar;
cb.Label.String = 'Change in dissolved oxygen concentration [mol/L]';
figure
contourf(Z,X,log(abs(difffe)))
set(gcf,'Position',[500 500 1000 400]);
figure
contourf(Z,X,(diffso))
colormap(gca,cmap_WRR);
set(gca,'FontName','Arial','FontSize',11,'LineWidth',1,'Box','on');
set(gcf,'Color','w');

cb = colorbar;
cb.Label.String = 'Change in sulfate concentration [mg/L]';
set(gcf,'Position',[500 500 1000 400]);

caxis([-50, 50]);