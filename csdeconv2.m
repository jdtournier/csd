function [ F_SH, num_it ] = csdeconv2 (R_RH, S, DW_scheme, HR_scheme, lambda, tau, reg)

% function [ F_SH, num_it ] = csdeconv2 (R_RH, S, DW_scheme, HR_scheme, lambda, tau, reg)
%
% Constrained spherical deconvolution:
%
% deconvolves the axially symmetric response function 'R_RH' (in RH
% coefficients) from the function defined by the measurements 'S' taken along
% the directions of 'DW_Scheme' to give the surface 'F_SH' (in SH
% coefficients), by constraining the corresponding amplitudes of 'F_SH'
% (calculated along the directions given by 'HR_scheme') to be non-negative.
% The optional parameters 'lambda', 'tau', and 'reg' correspond to the
% non-negativity regularisation weight (1 by default), the threshold on the
% FOD amplitude used to identify negative lobes (0 by default), and the
% regularisation on the FOD coefficients (1 by default).



if ~exist('lambda'), lambda = 1; end
if ~exist('tau'), tau = 0; end
if ~exist('reg'), reg = 1; end


% guess appropriate value of lmax (assuming no super-resolution):
lmax = lmax_for_SH (S);
if HR_scheme.lmax < lmax
  lmax = HR_scheme.lmax; 
end


% build forward spherical convolution matrix up to lmax:
m = [];
for l = 0:2:lmax
  m = [ m R_RH(l/2+1)*ones(1,2*l+1) ];
end
fconv = DW_scheme.sh.*m(ones(size(DW_scheme.sh,1),1),:);

% generate initial FOD estimate, truncated at lmax = 4:
F_SH = fconv(:,1:nSH_for_lmax(4))\S;
F_SH (end+1:size(HR_scheme.sh,2),1) = 0;

% set threshold on FOD amplitude used to identify 'negative' values:
threshold = tau*mean (HR_scheme.sh*F_SH);


% scale lambda to account for differences in the number of 
% DW directions and number of mapped directions;
lambda = lambda * size(fconv,1)*R_RH(1)/size(HR_scheme.sh,1);


fconv = [ fconv(:,1) fconv ];
fconv_HR = [ 0*HR_scheme.sh(:,1) HR_scheme.sh ];

F_SH = [ 0; F_SH ];

Mt_M = fconv' * fconv;
Mt_M(2:end,2:end) = Mt_M(2:end,2:end) + reg * eye(size(fconv,2)-1);
%Mt_M(1,1) = Mt_M(1,1) + 0.1*reg;
Mt_b = fconv' * S;

% main iteration loop:
k = [];
for num_it = 1:50
  A = fconv_HR*F_SH;
  k2 = find (A < threshold);
  if size(k) == size(k2), if k == k2, break; end; end;
  k = k2;
  M = Mt_M + lambda * fconv_HR(k,:)' * fconv_HR(k,:);
  F_SH = M \ Mt_b;
end


dc = F_SH(1)*fconv(1,1)
F_SH = F_SH(2:end);

