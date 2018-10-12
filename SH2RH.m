function RH = SH2RH (SH)

% function RH = SH2RH (SH)
%
% Calculate the rotational harmonic decomposition up to 
% harmonic order 'lmax'for an axially and antipodally 
% symmetric surface 'SH' (in SH coefficients). Note that
% all m~=0 coefficients will be ignored as axial symmetry
% is assumed.

lmax = lmax_for_SH (SH);
D_SH = gen_delta (0, 0, lmax);
k = find (D_SH);
RH = SH(k)./D_SH(k);


