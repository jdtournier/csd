function n = nSH_for_lmax (lmax)

% function n = nSH_for_lmax (lmax)
%
% returns the number of even SH coefficients for a 
% given harmonic order 'lmax'

n = (lmax+1)*(lmax+2)/2;
