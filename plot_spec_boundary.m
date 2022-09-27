%% plot_spec_boundary( DATA, NPOINTS, NEWFIG )
% =======================================================
%
% Traces the plasma boundary in the (R,Z) plane 
% with the specified number of points 
% 
% INPUT
% -----
%   -data     : must be produced by calling read_spec(filename)
%   -Npoints  : number of points for theta
%   -Newfig   : opens (=1) or not (=0) a new figure, or overwrites (=2)
%               last plot
%
% ------------------------------------%
% Written by S.Guinchard (05/17/22)   %
% ------------------------------------%

function plot_spec_boundary(d, Npoints, Newfig)

    Rbc = d.output.Rbc(:,2);
    Zbs = d.output.Zbs(:,2);
    
    N = 10000; 
    theta = linspace(0,2*pi, N);
    phi   = linspace(0,2*pi, N);
    
    m     = double(d.output.im);
    n     = double(d.output.in/d.input.physics.Nfp);
    R     = zeros(size(theta));    
    Z     = zeros(size(phi));
   
    R_    = zeros(1,Npoints);
    Z_    = R_;
    
    for i=1:length(m)
        for j =1:length(theta)
            R(j) = R(j) + Rbc(i)*cos(m(i)*theta(j) - n(i)*phi(1));
            Z(j) = Z(j) + Zbs(i)*sin(m(i)*theta(j) - n(i)*phi(1));
        end
    end
    

    for ii = 1:Npoints
        R_(ii) = R((ii-1)*floor(N/Npoints)+1);
        Z_(ii) = Z((ii-1)*floor(N/Npoints)+1);
    end

    p = polyshape(R,Z);
    figure 
    pg=plot(p);
    pg.FaceColor = ([1 1 1]);
    pg.EdgeColor = ([1 0 0]);
    pg.LineWidth =   3;
    hold on
    scatter(R_,Z_, 'filled', 'ko')
    xlabel('R')
    ylabel('Z')

%     switch Newfig
%         case 0
%         
%         case 1
%     
%         case 2
%     
%     end


end
