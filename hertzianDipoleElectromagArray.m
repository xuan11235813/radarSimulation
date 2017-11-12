function [Er, ETheta, HPhi] = hertzianDipoleElectromagArray(currentArray, r, theta, k, lineUnitLength)
% I ,r, theta are arrays
% k ,l are double number 

IE = k * lineUnitLength * currentArray;
mul = exp(-1j*k*r)./(4 * pi * r);
rP = 1./(1j*k*r);
rP2 = 1./((1j * k * r).^2);
Er = 1j * 2 * 377 * IE .* mul .* (rP + rP2) .* cos(theta);
ETheta = 1j * 377 * IE .* mul .* (1 + rP + rP2).* sin(theta);
HPhi = 1j * IE .* mul .* (1 + rP) .* sin(theta);