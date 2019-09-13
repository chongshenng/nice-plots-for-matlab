% w, h (in pc)

function set_figure_eps(w,h,wm,hm,fig_name,fig_path)

pc2cm = 0.42175; % 1pc = 0.42175cm

Fig=struct('w',w,'h',h,'rm',wm,'lm',wm,'bm',hm,'tm',hm);

% paper_width_cm  = Fig.w + Fig.lm + Fig.rm;
% paper_height_cm = Fig.h + Fig.bm + Fig.tm;

paper_width_pc  = Fig.w + Fig.lm + Fig.rm;
paper_height_pc = Fig.h + Fig.bm + Fig.tm;

paper_width_cm  = paper_width_pc  * pc2cm;
paper_height_cm = paper_height_pc * pc2cm;

if nargin == 5
    set(gcf,'Name',fig_name);
end

if nargin < 6
    fig_path = [pwd,'/'];
end

if verLessThan('matlab', '8.2')
    fig1 = gcf;
else
    fig1 = get(gcf,'number');
end

set(fig1,'paperpositionmode','manual',...
    'Units','centimeters',...
    'position', [5 5 paper_width_cm paper_height_cm], ...
    'paperunits', 'centimeters', ...
    'papersize', [paper_width_cm paper_height_cm], ...
    'paperposition',[0 0 paper_width_cm paper_height_cm])

set(fig1,'color','none','InvertHardCopy','off')

% width=(Fig.w);
% height=(Fig.h);
% set(gca,'Units','centimeters','position',...
% [Fig.lm, Fig.bm, width, height]);
% set(gca,'color','none')
% 
% set(gca,'fontsize',fsize);
% h=get(gca,'xlabel');
% % set(h, 'FontSize', fsize)
% h=get(gca,'ylabel');
% set(h, 'FontSize', fsize)
% h=get(gca,'title');
% set(h, 'FontSize', fsize)

% drawnow;
% laprint(fig1,[fig_path,fig_name],...
%     'options','factory','factor',1,...
%     'figcopy','off','width',paper_width_cm,'asonscreen','on');
% fix_lines(sprintf('%s.eps',fig_name));