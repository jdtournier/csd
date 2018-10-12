function plot_SH (SH, scheme)

% function plot_SH (SH, scheme)
%
% plot surface given by SH coefficients supplied in 'SH' along 
% the set of directions in 'scheme'

plot_amp (SH2amp (SH, scheme), scheme);
