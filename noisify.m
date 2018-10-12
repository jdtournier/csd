function S = noisify(S, noise)

% function S = noisify(S, noise)
%
% Add quadrature noise to signals S, with standard deviation 
% 'noise'.

Nx = noise*randn(size(S,1),1);
Ny = noise*randn(size(S,1),1);
S = sqrt((S+Nx).^2 + Ny.^2);
  
