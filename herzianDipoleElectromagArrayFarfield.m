function [Er, ETheta, HPhi] = herzianDipoleElectromagArrayFarfield(currentArray, r, theta, k, lineUnitLength)
% I ,r, theta are arrays
% k ,l are double number 

IE = k * lineUnitLength * currentArray;
mul = exp(-1j*k*r)./(4 * pi * r);
ETheta = 1j * 377 * IE .* mul .* sin(theta);
Er = 0;
HPhi = 1j * IE .* mul .* sin(theta);