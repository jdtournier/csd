function s = eval_ALP(l, el)

% syntax: s = eval_ALP(l, el)
%
% evaluates the Associated Legendre Polynomial at elevations 'el'
% for harmonic order l.

  s = legendre(l, cos(el'));
  for m = 0:l
    s(m+1,:) = s(m+1,:).*sqrt((2*l+1)*factorial(l-m) / ((4*pi)*factorial(l+m)));
  end

  if l
    s = [ s(end:-1:2,:); s ];
  end
