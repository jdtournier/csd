function scheme = gen_scheme(N, lmax)

% function scheme = gen_scheme(N, lmax)
%
% Generate a set of orientations in the required format, along
% with the corresponding SH transform information up to 
% harmonic order 'lmax'.
%
% If N is a string, it will attempt to load the specified
% file.
%
% If N is a number, a scheme with the specified number of
% directions will be generated using the equidistribute.m 
% script (note that these are not perfectly uniformly
% distributed).
%
% If N is a nx3 matrix, it will assume that each row provides
% an [ x y z ] vector pointing along the desired direction.
% 

if ischar(N)
  N = load(N);
end

if size(N,1) == 1 & size(N,2) == 1
  P = c2s(equidistribute(N));
elseif size(N,2) >= 3
  n = sqrt(sum(N(:,1:3).^2,2));
  k = find(n);
  X = N(k,1:3)./repmat(n(k),1,3);
  P = c2s(X);
else
  P = N;
end

scheme.el = P(:,1);
scheme.az = P(:,2);

scheme.sh = [];
scheme.lmax = lmax;

for l = 0:2:lmax
  scheme.sh = [ scheme.sh eval_SH(l, scheme.el, scheme.az)' ];
end

scheme.vert= s2c([ scheme.el scheme.az 1+0*scheme.az]);
scheme.mesh = convhulln(scheme.vert);
