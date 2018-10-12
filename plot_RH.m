function plot_RH(RH, scheme)

% function plot_RH(RH, scheme)
%
% plot surface given by RH coefficients supplied in 'RH' along 
% the set of directions in 'scheme'

plot_SH (sconv (RH, gen_delta(0, 0, 2*(size(RH,1)-1))), scheme);
