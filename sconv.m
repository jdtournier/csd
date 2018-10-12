function S_SH = sconv (R_RH, F_SH)

% function S_SH = sconv (R_RH, F_SH)
%   
% convolves the axially symmetric response function 'R_RH'
% (in RH coefficients) with the surface 'F_SH' (in SH 
% coefficients) to give the surface 'S_SH' (in SH coefficients).

b = [];
lmax = lmax_for_SH (F_SH);

for l = 0:2:lmax
  b = [ b; R_RH(l/2+1)*ones(2*l+1,1) ];
end

S_SH = b.*F_SH;
