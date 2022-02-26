function plotHalfFilledCavity (errorHalfToPlot, lengthHalfToPlot)
    % PLOTHALFFILLEDCAVITY generates part of the Fig. 5
    % PLOTHALFFILLEDCAVITY (errorHaltToPlot, lengthHalfToPlot) takes
    % as parameter the results from mainHalfFilledCavity and represent
    % them in a log-log scale.
    % See also MAINHALFFILLED.

    close all

    set(0,'defaultAxesFontName', 'CMU Serif')

    figHandle = figure;
    set(figHandle, 'defaultLegendAutoUpdate', 'off')

    loglog(1./lengthHalfToPlot(1,:), errorHalfToPlot(1,:), '-.o', 'linewidth', 2)
    hold on

    title('First eigenvalue error for half-filled cavity')
    grid on
    xlabel('1/h')
    ylabel('Relative error')
    set(gca,'fontsize',16)

    xlim([1 3000])
    ylim([8e-7 1e-1])
    lengthOriginTriangle = 20;
    error1 = 1e-4;
    error2 = 1e-6;

    k = 4;
    colorOrder4 = [0.4940, 0.1840, 0.5560];
    line([lengthOriginTriangle lengthOriginTriangle], [error1 error2], 'linewidth', 2, 'Color', colorOrder4)
    % Pendiente.
    length2 = 1/10^(log10(1/lengthOriginTriangle)-(log10(error1)-log10(error2))/k);
    h1 = loglog([lengthOriginTriangle length2], [error1 error2]);
    set(h1, 'Color', colorOrder4)
    set(h1, 'linewidth', 2)
    line([lengthOriginTriangle length2], [error2 error2], 'linewidth', 2, 'Color', colorOrder4)
    text(lengthOriginTriangle+10, error1/2, ' k=4', 'fontsize', 18, 'fontweight', 'bold', 'fontname','CMU Serif', 'Color', colorOrder4)