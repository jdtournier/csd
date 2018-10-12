function [ F_SH, num_it ] = csdeconv (R_RH, S, DW_scheme, HR_scheme, lambda, tau)

% function [ F_SH, num_it ] = csdeconv (R_RH, S, DW_scheme, HR_scheme, lambda, tau)
%
% Constrained spherical deconvolution:
%
% deconvolves the axially symmetric response function 'R_RH' (in RH
% coefficients) from the function defined by the measurements 'S' taken along
% the directions of 'DW_Scheme' to give the surface 'F_SH' (in SH
% coefficients), by constraining the corresponding amplitudes of 'F_SH'
% (calculated along the directions given by 'HR_scheme') to be non-negative.
% The optional parameters 'lambda' and 'tau' correspond to the regularisation
% weight (1 by default) and the threshold on the FOD amplitude used to identify
% negative lobes (0.1 by default).



if ~exist('lambda'), lambda = 1; end
if ~exist('tau'), tau = 0.1; end


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


% main iteration loop:
fconv(:,end+1:size(HR_scheme.sh,2)) = 0;
k = [];
for num_it = 1:50
  A = HR_scheme.sh*F_SH;
  k2 = find (A < threshold);
  if size(k2,1) + size (fconv,1) < size(HR_scheme.sh,2)
    disp ('too few negative directions identified - failed to converge');
    return; 
  end
  if size(k) == size(k2), if k == k2, return; end; end
  k = k2;
  M = [ fconv; lambda*HR_scheme.sh(k,:) ];
  F_SH = M\[ S; zeros(size(k,1),1) ];
end

disp ('maximum number of iterations exceeded - failed to converge');

