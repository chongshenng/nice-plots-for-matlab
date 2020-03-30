clear all; close all;

%-- Sets a nice background for exporting the final figure
set(0,'DefaultFigureColor','w',...              % Sets figure background to white
    'DefaultAxesColor','w',...                  % Sets axes background to white
    'DefaultFigureInvertHardCopy','off',...     % 'off' preserves on-screen colour
    'DefaultLineLineWidth',0.75,...             % This is to specify line width
    'DefaultAxesFontName','Times',...           % Secify axes font name
    'DefaultTextInterpreter','latex',...        % Secify text interpreter
    'DefaultAxesFontsize',10,...                % Specify axes font size = 10
    'DefaultLineMarkerSize',10);                % Specify line marker size = 10

%-- Add paths to all subroutines so that you can use them
addpath(genpath('subroutines'));

%-- First load some sample data
filename = 'data/data_plot2D.dat';
fid      = fopen(filename, 'r');

%-- Skip the first 72 lines
for i = 1:72
    str = fgets(fid);   
end
[data, ~] = fscanf(fid, '%f', inf);

%-- Reshape data to preserve structure
couette_retau220_mean = reshape(data,6,96)';

%-- Now plot the data
figure(1)
h1 = semilogx(couette_retau220_mean(:,2),couette_retau220_mean(:,3),'b-','linewidth',2);
hold on;

%-- I'm a turbulence researcher, so here's the log-law
kappa = 0.41;
xlin = logspace(0.0,1.1,50);
ylin = xlin;
xlog = logspace(1.0,3.0,50);
ylog = 1.0/kappa*log(xlog)+5.1;
figure(1)
hlin = plot(xlin,ylin,'k--');
hlog = plot(xlog,ylog,'k--');

%-- Now format FIGURE 1
figure(1)
xlim([1e-1 1e3]);
ylim([0 25]);
set(gca,'PlotBoxAspectRatio',[4 3 1]);  % 4:3 is a pleasing aspect ratio
set(gca,'xtick',logspace(-1,5,7));
set(gcf,'Position',[100 100 4*50 3*50])
xlabel('$x^+$','interpreter','latex');
ylabel('$\overline{v}^+$','interpreter','latex');

%-- Now put a colored patch here
%-- Viscous sublayer
xp = [1e-2 7 7 1e-2 1e-2];
yp = [0 0 25 25 0];
hp = patch(xp,yp,[1.0,0.9,0.9]);
set(hp,'FaceAlpha',.8,'LineStyle','none');
uistack(hp,'bottom')

%-- Buffer region
xp = [7 20 20 7 7];
hp = patch(xp,yp,[0.9,1.0,0.9]);
set(hp,'FaceAlpha',.8,'LineStyle','none');
uistack(hp,'bottom')

%-- Log to outer region
xp = [20 1e3 1e3 20 20];
hp = patch(xp,yp,[0.9,0.9,1.0]);
set(hp,'FaceAlpha',.8,'LineStyle','none');
uistack(hp,'bottom')

%-- For control over text placement
limx = get(gca,'xlim');
limy = get(gca,'ylim');
limx_interval   = log10(limx(2)) - log10(limx(1));
limy_interval   =       limy(2)  -       limy(1);
limx_mid        = limx(1) * 10^(0.5 * limx_interval);
limy_mid        = limy(1) +    (0.5 * limy_interval); 
t1 = text(limx(1)*10^(-0.15*limx_interval),limy(1)+(limy_interval),'($a$)');

%-- Apply following formats to all figures
for k = 1
    fig = figure(k);
    set(gca,'ticklength',[0.025 0.025],'layer','top');
    set(findall(fig,'type','text'),'HorizontalAlignment','center')
    set(findall(fig,'type','axes'),'linewidth',0.75)
    set(gca,'TickLabelInterpreter','latex');
end

%% PLOTTING OPTION 1
%-- I use export_fig which generates beautiful true-screen output
figure(1);
%-- First save the background patch as png
box off; axis off;      % Switches off axes boundaries
t1.Visible = 'off';     % Switches off text
h1.Visible = 'off';     % Switches off line plot
hlin.Visible = 'off';   % Switches off linear plot
hlog.Visible = 'off';   % Switches off log plot
export_fig('figs/uavg_raw_bg','-rgb','-png','-m2');

%-- Now save the figure without the patch
h = findall(gcf,'type','patch');  delete(h);
box on; axis on;
t1.Visible = 'on';
h1.Visible = 'on';
hlin.Visible = 'on';
hlog.Visible = 'on';
set(gcf,'Color','none');
set(gca,'Color','none');
export_fig('figs/uavg_raw','-rgb','-pdf');

% %% PLOTTING OPTION 2
% %-- For more 'hardcore' control, I use figure_eps, which is a
% %   wrapper for laprint (a LaTeX figure generator) with cleanup tools.
% 
% %-- First remove the text interpreters.
% for k = 1
%     fig = figure(k);
%     set(findall(fig,'type','text'),'Interpreter','none')
% end
% 
% figw   = 34;
% figh   = figw/4*3;
% figw_m = 0;
% figh_m = 0 ;
% 
% %-- Now generate the figure with labels for psfrag
% figure(1)
% figure_eps(figw, figh, figw_m, figh_m, 'figs/uavg_eps');
    