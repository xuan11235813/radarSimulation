% generate the current
lineNum = 100;
lineUnitLength = 0.001;
I0 = 0.05;
k = 200;
incidentAngle = pi/9;
currentArray= constantCurrent( lineNum, lineUnitLength, I0, k, incidentAngle);
%currentArray= calculateCurrent( lineNum, lineUnitLength, I0, k, incidentAngle);


r = 20;
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
axis equal


