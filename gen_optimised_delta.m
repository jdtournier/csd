function SH = gen_optimised_delta(el, az, lmax)

% function SH = gen_optimised_delta(el, az, lmax)
%
% Generate the SH coefficients for a delta function pointing
% along [ el az ] up to harmonic order 'lmax', optimised for 
% non-negativity

HR_scheme = gen_scheme ('dir300.txt', lmax);
response = eval_DT (0.8, 3, HR_scheme);
response_sh = amp2SH (response, HR_scheme);
SH = csdeconv (SH2RH(response_sh), response, HR_scheme, HR_scheme);
