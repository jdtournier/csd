function S = c2s(X)
  
% function S = c2s(X)
%
% Convert cartesian coordinates to the equivalent spherical coordinates.
% Assumes X = [ X Y Z ], and returns S = [ el az r ].
  
S(:,3) = sqrt(sum(X.^2, 2));
S(:,1) = acos(X(:,3)./S(:,3));
S(:,2) = atan2(X(:,2), X(:,1));
