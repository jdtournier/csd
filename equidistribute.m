function X = equidistribute(N)
% X = equidistribute(N)
% uses the formula in [saff:dmp:1997] to generate equidistributed
% points on the sphere.
% INPUT: N is the number of points, default=12
% 
% OUTPUT: X is the set of points as a Nxd matrix, one point per row
%         if no output is specified, the points are plotted using scatter3.
% REFERENCE
% @Article{saff:dmp:1997,
%  author =          {Saff, E. B. and Kuijlaars, A. B. J.},
%  title =          {Distributing Many Points on a Sphere},
%  journal =          {Math. Intell.},
%  year =          {1997},
%  volume =          {19},
%  number =          {1},
%  pages =          {5--11},
%}


X = zeros(N,3);

for k=1:N
  h = -1 + 2*(k-1)/(N-1);
  theta(k) = acos(h);
  if k==1 | k==N 
    phi(k) = 0;
  else 
    phi(k) = mod(phi(k-1) + 3.6/sqrt(N*(1-h^2)),2*pi);
  end;
  X(k,:) = [ cos(phi(k))*sin(theta(k)), ...
	     sin(phi(k))*sin(theta(k)), ...
	     cos(theta(k)) ];
end;

%if nargout == 0
  %Z = zeros(size(X));
  %[SX,SY,SZ] = sphere;
  %scatter3(X(:,1),X(:,2),X(:,3),'filled')
  %hold on
  %sph2 = surf(SX,SY,SZ);
  %set(sph2, 'FaceColor', [ 1 1 0 ]);
  %axis vis3d
%end
