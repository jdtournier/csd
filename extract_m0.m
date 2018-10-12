function SH_ax = extract_m0 (SH)

% function SH_ax = extract_m0 (SH)
%
% extract the m=0 (axially symmetric) terms from SH

SH_ax = [];
l = 0;
while 1
  i = l*(l+1)/2+1;
  if i > size(SH,1), break; end
  SH_ax = [ SH_ax; SH(i,:) ];
  l = l+2;
end

