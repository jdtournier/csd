function S = SH2amp (SH, scheme)

% function S = SH2amp (SH, scheme)
%
% Maps SH coefficients 'SH' to amplitudes along directions
% in 'scheme'

S = scheme.sh(:, 1:size(SH,1))*SH;
