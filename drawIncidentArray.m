% generate the current
lineNum = 400;
lineUnitLength = 0.001;
I0 = 0.05;
k = 200;
incidentAngle = pi/9;
%currentArray= constantCurrent( lineNum, lineUnitLength, I0, k, incidentAngle);
currentArray= calculateCurrent( lineNum, lineUnitLength, I0, k, incidentAngle);


r = 2;
thetaStep = 0.005;
phiStep = 0.005;
thetaArray = -pi/2:thetaStep:pi/2;
phiArray  = -pi:phiStep:pi;
[thetaMesh ,phiMesh] = meshgrid(thetaArray, phiArray);

[height, width] = size(thetaMesh);
rhoMesh = zeros(height, width);

for i = 1:height
    for j = 1:width
        theta = thetaMesh(i,j);
        phi = phiMesh(i,j);
        x0 = r * cos(theta)*cos(phi);
        y0 = r * cos(theta)*sin(phi);
        z0 = r * sin(theta);
        [Er, ETheta] = calculateMultiDrection( lineNum, lineUnitLength, [x0,y0,z0],currentArray, k);
        r1 = norm(Er + ETheta);
        rhoMesh(i,j) = r1;
    end
end

[X, Y, Z] = sph2cart(phiMesh, thetaMesh, rhoMesh);

mesh(X,Y,Z);



% r = 3;
% x = -r:0.01:r;
% y = -r:0.01:r;
% [xMesh, yMesh] = meshgrid(x,y);
% S = (xMesh.^2 + yMesh.^2 < r^2);
% N = numel(S(:));
% X = zeros(N,1);
% Y = zeros(N,1);
% Z = zeros(N,1);
% 
% p = 1;
% 
% for i  = 1:numel(x)
%     for j = 1:numel(y)
%       if (x(i)^2 + y(j)^2) < r^2
%           x0 = x(i);
%           y0 = y(j);
%           z0 = sqrt(r^2 - x0^2 - y0^2);
%           theta = acos(z0/r);
%           phi = atan2(y0, x0);
%           [Er, ETheta] = calculateMultiDrection( lineNum, lineUnitLength, [x0,y0,z0],currentArray, k);
%           r1 = norm( ETheta);
%           z1 = r1 * cos(theta);
%           x1 = r1 * sin(theta) * cos(phi);
%           y1 = r1 * sin(theta) * sin(phi);
%           X(p) = x1;
%           Y(p) = y1;
%           Z(p) = z1;
%           p = p + 1;
%       end
%     end
% end
% 
% plot3(X,Y,Z)
% 
% figure;
% xMax = max(abs(X));
% yMax = max(abs(Y));
% xStep = xMax/100;
% yStep = yMax/100;
% x_ = -xMax : xStep :xMax;
% y_ = -yMax : yStep :yMax;
% [xMesh, yMesh] = meshgrid(x_,y_);
% zMesh = zeros(size(xMesh));
% 
% 
% [height, width] = size(zMesh);
% for i = 1:height
%     for j = 1:width
%         x1 = xMesh(i,j);
%         y1 = yMesh(i,j);
%         [~, index] = min((X - x1).^2 + (Y - y1).^2);
%         zMesh(i,j) = Z(index);
%     end
% end
% 
% mesh(xMesh, yMesh, zMesh);