function F_SH = sdeconv(R_RH, S_SH)

% function F_SH = sdeconv(R_RH, S_SH)
%
% deconvolves the axially symmetric response function 'R_RH'
% (in RH coefficients) from the surface 'S_SH' (in SH 
% coefficients) to give the surface 'F_SH' (in SH coefficients).

b = [];
lmax = lmax_for_SH (S_SH);

for l = 0:2:lmax
  b = [ b; ones(2*l+1,1)./R_RH(l/2+1) ];
end

F_SH = b.*S_SH;

