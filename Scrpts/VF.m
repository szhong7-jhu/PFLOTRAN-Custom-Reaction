name='VF2';
back='.csv';
% Color-blind-friendly diverging colormap
ncol = 256;
cmap_WRR = interp1([0 0.5 1], ...
    [0.20 0.45 0.70; ...
     0.96 0.96 0.96; ...
     0.85 0.37 0.08], ...
    linspace(0,1,ncol),'linear');
% 1. Define the number of color levels (default is usually 256)
num_colors = 256; 

% 2. Create a custom gray scale that goes from 0 (black) to 0.85 (light gray)
max_gray = 0.85; % Adjust this down if it is still too bright
gray_scale = linspace(0, max_gray, num_colors)';

% 3. Duplicate it into 3 columns for RGB [R, G, B]
custom_gray = [gray_scale, gray_scale, gray_scale];


file=append(name,back);
M = readmatrix(file);
vf=M(1:end,2);
volume=reshape(vf,2020,1000);
%volume(volume==0)=nan;
volume=volume';
volume(volume==0)=nan;

volumenew=volume;
volumenew(volume<=0.035)=0.002;
volumenew(volume>0.035)=0.06;

volume1 = [0.06.*ones(1,2020);volume(1:999,:)];
volume2 = reshape(volume1',2020000,1);
% % volume=reshape(vf,1000,2020);
Z=0.5:0.5:1010;
X=0.4:0.4:400;

contourf(Z,X,volume)
colormap(custom_gray);
set(gca,'FontName','Arial','FontSize',11,'LineWidth',1,'Box','on');
set(gcf,'Color','w');
set(gcf,'Position',[500 500 1000 400]);
% caxis([0.002, 0.06]);
colorbar;
figure
contourf(Z,X,volumenew)
colormap(custom_gray);
set(gca,'FontName','Arial','FontSize',11,'LineWidth',1,'Box','on');
set(gcf,'Color','w');
set(gcf,'Position',[500 500 1000 400]);
caxis([0.002, 0.06]);
colorbar;
 OXI=[];
 UNOXI=[];
  for i = 1:length(vf)
      if vf(i)<=0.036
          OXI=[OXI;i];
      else 
          UNOXI=[UNOXI;i];
      end
  end
    
