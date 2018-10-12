function lmax = lmax_for_SH (SH)

% function lmax = lmax_for_SH (SH)
%
% returns lmax given 'SH', a vector of even SH coefficients

lmax = 2*(floor(sqrt(1+8*size(SH,1))-3)/4);
