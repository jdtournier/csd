% Here is a sample session to give you a feel for how things work.
% 
% First, we need to generate 3 different sets of directions ('schemes').
% 
% The first one, 'pscheme', is used for plotting the surfaces, and is 
% generated at a pretty high resolution (8000 vertices here). We also 
% specify a value of 'lmax' which at least as high as we're going to use:
pscheme = gen_scheme (8000, 16);

% The second one is the actual DW scheme used, or that we're about to 
% simulate. In this case, it is read from file, and 'lmax' is set to 
% a value that makes sense for that scheme (in this case, lmax = 8 as 
% the number of parameters would be too high for lmax = 10):
DW_scheme = gen_scheme ('dir60.txt', 8);

% This last scheme is the one along which FOD values will be calculated, 
% so that negative values can be identified. It is used only with the 
% constrained version. The value of lmax in this case will instruct the 
% CSD method of the desired output harmonic order. Thus, setting lmax to
% a value greater than can be reconstructed with 'standard' spherical 
% deconvolution will make the CSD method use super-resolution.
HR_scheme = gen_scheme ('dir300.txt', 8);

% Here, we simulate two diffusion tensors crossing at 45°, assuming each 
% has FA = 0.8, and a b-value of 3000. The DW signal is computed along the 
% directions of 'DW_scheme':
S = eval_DT (0.8, 3, DW_scheme, pi/2, 0) + eval_DT (0.8, 3, DW_scheme, pi/2, pi/4);

% Add quadrature noise (here, SNR = 20, sd = 0.05) to the simulated 
% DW signals and convert to SH coefficients:
S_noise = noisify (S, 0.05);
S_SH = amp2SH (S_noise, DW_scheme);

% Create the SH coefficients for a response function computed from the
% tensor model (FA = 0.8, b-value = 3000). Here, the high-resolution 
% 'pscheme' direction set is used, as it should produce robust results.
% In practice, this response function can/should be measured directly 
% from the data itself.
R_SH = amp2SH (eval_DT (0.8, 3, pscheme), pscheme);

% Convert the SH coefficients of the response function to RH coefficients:
R_RH = SH2RH (R_SH);

% Now we can perform the spherical deconvolution itself, and plot the 
% results in each case:
%
% First, 'standard' unfiltered spherical deconvolution:
subplot (2,2,1); title 'unfiltered spherical deconvolution';
F_SH_unfiltered = sdeconv (R_RH, S_SH);
plot_SH (F_SH_unfiltered, pscheme)

% Next, 'standard' filtered spherical deconvolution. Note that the
% filtering coefficients are supplied as their reciprocals - the 
% filter coefficients here are actually [ 1 1 1 0.1 0.01 inf inf inf ] 
% (the last four correspond to lmax > 8 and are unused):
subplot (2,2,2); title 'filtered spherical deconvolution';
F_SH_filtered = sdeconv (R_RH.*[1 1 1 2 10 0 0 0 0 ]', S_SH);
plot_SH (F_SH_filtered, pscheme)

% Next, constrained spherical deconvolution. Here, we need to supply
% a set of directions along which the FOD will be evaluated. This 
% function can also take two additional optional arguments to set 
% the value of lambda and tau (type 'help csdeconv' for more info).
% The optional return variable 'num_it' gives the number of iterations 
% performed:
subplot (2,2,3); title 'constrained spherical deconvolution';
[ F_SH_csd, num_it ] = csdeconv (R_RH, S_noise, DW_scheme, HR_scheme);
plot_SH (F_SH_csd, pscheme)

% Finally, super-resolved constrained spherical deconvolution. This is 
% the same as above, but this time we set the 'lmax' parameter for
% 'HR_scheme' to a value greater than can normally be handled with 
% 'standard' spherical deconvolution:
subplot (2,2,4); title 'super-resolved constrained spherical deconvolution';
HR_scheme = gen_scheme ('dir300.txt', 12);
[ F_SH_srcsd, num_it ] = csdeconv (R_RH, S_noise, DW_scheme, HR_scheme);
plot_SH (F_SH_srcsd, pscheme)
