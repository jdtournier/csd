function P = SH_power (SH)

% function P = SH_power (SH)
%   
% output the power contained within each harmonic order of 'SH'

b = [];
P = [];
lmax = lmax_for_SH (SH);

for l = 0:2:lmax
  b = [ b; l*ones(2*l+1,1) ];
  SHl = SH(find(b==l));
  P(l/2+1) = sum(SHl.^2);
end


