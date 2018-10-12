function [ S, mod_scheme ] = eval_ellipsoid (FA, b, scheme, ev_el, ev_az)

% function S = eval_ellipsoid (FA, b, scheme, ev_el, ev_az)
%
% Evaluate the ellipsoid of the diffusion tensor along the 
% directions specified in 'scheme', assuming a diffusion tensor
% model with the specified FA, using a b-value of 'b' x10^3 s/mm^2
% and a mean ADC of 900 x10^6 mm^2/s. Optionally, the tensor can be 
% oriented along the direction [ ev_el ev_az ].


if ~exist('ev_el')
  ev_el = 0;
  ev_az = 0;
end  

a = FA/sqrt(3-2*FA^2);
D = 0.75*[ 1-a 0 0; 0 1-a 0; 0 0 1+2*a ];
R_az = [ cos(ev_az) -sin(ev_az) 0
         sin(ev_az)  cos(ev_az) 0
	     0           0      1 ];
R_el = [ cos(ev_el)   0  sin(ev_el)
             0        1     0
	 -sin(ev_el)  0  cos(ev_el) ];

D = R_az*R_el*D*R_el'*R_az';

%D = [1 0 0; 0 0.5 0; 0 0 1];
	 
C = s2c([ scheme.el scheme.az 1+0*scheme.az ])';

x = (D*C)';
S = sqrt(sum(x.^2,2));
x = x./repmat (S, 1, 3);
mod_scheme = gen_scheme (x, scheme.lmax);
   

