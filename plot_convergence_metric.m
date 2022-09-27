%% plot_convergence_metric( BDATA_ARR, INV, METRIC, NEWFIG )
% =============================================
% 
% Makes the plot for the convergence study of the Metric specified 
% in argument
% 
% INPUT
% -----
%   -data_arr : array of data -  must be produced by calling read_boozer
%   -metric   : 'QA', 'QH' the type of metric you want to try the
%   convergence
%   -inv      : plot against Mpol_boz (=1) otherwise 1/Mpol_boz (=0)
%   -Newfig   : opens (=1) or not (=0) a new figure, or overwrites (=2)
%   last plot
%
% ------------------------------------%
% Written by S.Guinchard (05/15/22)   %
% ------------------------------------%

function plot_convergence_metric(b_arr, metric,  inv, Newfig)
    %% Initilisation
    metric_arr = zeros(size(b_arr));
    Mpol_arr   = zeros(size(b_arr));
    
    switch metric
        case 'QA'
            parfor ii=1:length(b_arr)
               metric_arr(ii) = get_metric_QA(b_arr(ii));
               Mpol_arr(ii) = b_arr(ii).Booz_xForms.Inputs.mpol;
            end
            
        case 'QH'
            parfor ii=1:length(b_arr)
               metric_arr(ii) = get_metric_QH(b_arr(ii),1);
               Mpol_arr(ii) = b_arr(ii).Booz_xForms.Inputs.mpol;
            end
                
    end
    
    switch Newfig
        case 0 
            hold on 
        case 1
            figure 
        case 2 
            hold off
    end

    switch inv
                case 1
                    semilogy(1./Mpol_arr, metric_arr, 'k+', 'linewidth', 2, 'markersize', 10)
                    p = polyfit(1./Mpol_arr,log(metric_arr),1);
                    set (gca, 'fontsize', 16)
                    grid ON
                    xlabel('$\frac{1}{Mpol_{boz}}$', 'fontsize', 20, 'Interpreter','latex')
                    ylabel(strcat('$\log_{10}(f_{',metric,'})$'), 'fontsize', 20, 'Interpreter','latex')
                case 0 
%                     plot(Mpol_arr, log(metric_arr), 'k+', 'linewidth', 2, 'markersize', 10)
%                     p = polyfit(Mpol_arr,log(metric_arr),1);
%                     set (gca, 'fontsize', 16)
%                     grid ON
%                     xlabel('${Mpol_{boz}}$', 'fontsize', 20, 'Interpreter','latex')
%                     ylabel(strcat('$\log_{10}(f_{',metric,'})$'), 'fontsize', 20, 'Interpreter','latex')
                
%                     figure
                    plot(Mpol_arr, metric_arr, 'k+', 'linewidth', 2, 'markersize', 10)
                    p = polyfit(Mpol_arr,metric_arr,1);
                    set (gca, 'fontsize', 16)
                    grid ON
                    xlabel('${Mpol_{boz}}$', 'fontsize', 20, 'Interpreter','latex')
                    ylabel(strcat('$f_{',metric,'}$'), 'fontsize', 20, 'Interpreter','latex')
    end
end