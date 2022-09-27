%% get_metric_QA(BDATA)
% ======================
%
% Extract the QA metric of a Booz_xForms output
%
% INPUT
% -----
%   -bdata: must be produced using read_boozer
%   
% OUTPUT
% ------
%   -metric: the value of the QA_metric
%    computed summing all bmnc_b^2 modes 
%    s.t n=!0 and normalising by mn_b*bmnc_b(0)^2
%
% ------------------------------------%
% Written by S.Guinchard (05/12/22)   % 
% ------------------------------------%
function metric = get_metric_QA(b)

    bmnc_b = b.Booz_xForms.Outputs.bmnc_b;
    xn_b   = b.Booz_xForms.Outputs.xn_b;
    ind    = find(xn_b ~= 0);
    metric = sum(bmnc_b(ind).^2)/(bmnc_b(1)^2); % Not divide enables convergence
    %metric = sum(bmnc_b(ind).^2)/(length(ind)*bmnc_b(1)^2);

end