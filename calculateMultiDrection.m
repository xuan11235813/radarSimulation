function [Er, ETheta] = calculateMultiDrection( lineNum, lineUnitLength, targetPointCood,currentArray, k)

lineCood = zeros(numel(lineNum), 3);
center = lineNum * lineUnitLength/2;
for i = 1:lineNum
    zCood = (i-0.5) * lineUnitLength - center;
    lineCood(i,3) = zCood;
end


directionVector = targetPointCood - lineCood;
z = directionVector(:,3);
r = sqrt(sum(directionVector.^2, 2));
directionVector = directionVector./r;
theta = acos(z./r);
[ErArray, EThetaArray, ~] = hertzianDipoleElectromagArray(currentArray, r, theta, k, lineUnitLength);
Er = real(sum(ErArray.* directionVector,1));
ETheta = real(sum(EThetaArray .* directionVector,1));

