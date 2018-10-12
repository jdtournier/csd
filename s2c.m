function X = s2c(S)

% function X = s2c(S)
%  
% Convert spherical coordinates to the equivalent cartesian coordinates.
% Assumes S = [ el az r ], and returns X = [ X Y Z ].
  
X = [ S(:,3).*cos(S(:,2)).*sin(S(:,1)), ...
      S(:,3).*sin(S(:,2)).*sin(S(:,1)), ...
      S(:,3).*cos(S(:,1)) ];
