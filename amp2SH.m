function SH = amp2SH (S, scheme);

% function SH = amp2SH (S, scheme);
%
% Maps signals 'S' measured along directions in 'scheme'
% the corresponding even SH coefficients

if ~isfield (scheme, 'shinv')
  scheme.shinv = pinv(scheme.sh);
end

SH = scheme.shinv * S;

