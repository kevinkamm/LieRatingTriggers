function Figures=plotTrajectories(t,Rexp,Rjlt,varargin)
backgroundColor='w';
textColor = 'k';
figureRatio = 'fullScreen';
visible='on';
showTitle=false;
for iV=1:2:length(varargin)
    switch varargin{iV}
        case 'backgroundColor'
            backgroundColor = varargin{iV+1};
        case 'figureRatio'
            figureRatio = varargin{iV+1};
        case 'textColor'
            textColor  = varargin{iV+1};
        case 'visible'
            visible  = varargin{iV+1};
        case 'showTitle'
            showTitle  = varargin{iV+1};
    end
end

[N,M]=size(Rexp,[3,4]);
wi=1;
Figures={};
legendEntries=beginFigure();
xLabel='t';
yLabel='';
titleStr='';
for iR=1:1:size(Rexp,1)-1
    for jR=1:1:size(Rexp,2)
        nexttile;hold on;
        plotRexp(iR,jR);
        plotRjlt(iR,jR);
        tileLables(xLabel,yLabel,titleStr);
    end 
end
legendEntries={'Exp','JLT'};
endFigure(legendEntries);

    function plotRexp(iR,jR)
%         tempR=squeeze(Rexp(iR,jR,:,:));
%         tempR(end,:)=nan;
%         patch(reshape(t,[],1).*ones(1,M),...
%                  tempR,...
%                  .1*ones(size(tempR)),...
%                  'EdgeColor',[108,110,107]./255,'EdgeAlpha',.02,...
%                  'LineWidth',.1);

        plot(t,squeeze(Rexp(iR,jR,:,wi)),'b-');


    end
    function plotRjlt(iR,jR)
%         tempR=squeeze(Rjlt(iR,jR,:,:));
%         tempR(end,:)=nan;
%         patch(reshape(t,[],1).*ones(1,M),...
%                  tempR,...
%                  .1*ones(size(tempR)),...
%                  'EdgeColor',[108,110,107]./255,'EdgeAlpha',.02,...
%                  'LineWidth',.1);

        plot(t,squeeze(Rjlt(iR,jR,:,wi)),'r--');


    end

    function legendEntries=beginFigure()
        legendEntries={};
        Figures{end+1}=newFigure('backgroundColor',backgroundColor,...
                                 'figureRatio',figureRatio,...
                                 'textColor',textColor,...
                                 'visible',visible);
        tiledlayout(size(Rexp,1)-1,size(Rexp,2));
    end
    function tileLables(xLabel,yLabel,titleStr)
        if ~strcmp(xLabel,'')
            xlabel(xLabel, 'fontweight', 'bold','Color',textColor,'Interpreter','latex')
        end
        if ~strcmp(yLabel,'')
            ylabel(yLabel, 'fontweight', 'bold','Color',textColor,'Interpreter','latex')
        end
        if ~strcmp(titleStr,'') && showTitle
            title(titleStr,'Color',textColor,'Interpreter','latex')
        end
    end
    function endFigure(legendEntries)      
        lgd=legend(legendEntries,...
          'NumColumns',4,...
          'Interpreter','latex',...
          'TextColor',textColor); 
        lgd.Layout.Tile = 'south';

    end
end