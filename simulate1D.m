% generate the current
lineNum = 1000;
lineUnitLength = 0.0002;
B0 = 0.01;
k = 500;
incidentAngle = pi/9;
length = lineNum * lineUnitLength;
sparkLength = 0.003;
dutyCycle = 0.3;

disk = generateDisk( ...
    'randomConductSpark', ...
    lineUnitLength, ...
    length, ...
    sparkLength, ...
    dutyCycle);
figure;
plot(disk);

figure;
% for i = 0:pi/200:pi/3
%     currentArray = calculateCurrentWithDisk(...
%         disk,...
%         B0,...
%         i,...
%         lineUnitLength,...
%         k);
% 
% 
%     r = 20;
%     thetaStep = 0.005;
%     phi = 0;
%     thetaArray = -pi/2:thetaStep:pi/2;
% 
%     rhoArray = zeros(1,numel(thetaArray));
% 
% 
%     for j = 1:numel(thetaArray)
%         theta = thetaArray(j);
%         phi = 0;
%         x0 = r * cos(theta)*cos(phi);
%         y0 = r * cos(theta)*sin(phi);
%         z0 = r * sin(theta);
%         [Er, ETheta] = calculateMultiDrection( lineNum, lineUnitLength, [x0,y0,z0],currentArray, k);
%         r1 = norm(Er + ETheta);
%         rhoArray(j) = r1;
%     end
%     
%     polarplot(thetaArray,rhoArray)
%     pause(0.1);
% end

currentArray = calculateCurrentWithDisk(...
        disk,...
        B0,...
        incidentAngle,...
        lineUnitLength,...
        k);
r = 2;
thetaStep = 0.01;
phiStep = 0.01;
thetaArray = 0:thetaStep:pi/2;
phiArray  = -pi:phiStep:pi;
[thetaMesh ,phiMesh] = meshgrid(thetaArray, phiArray);

[height, width] = size(thetaMesh);
rhoMesh = zeros(height, width);
disp(height)

parfor i = 1:height
    for j = 1:width
        theta = thetaMesh(i,j);
        phi = phiMesh(i,j);
        x0 = r * cos(theta)*cos(phi);
        y0 = r * cos(theta)*sin(phi);
        z0 = r * sin(theta);
        [Er, ETheta] = calculateMultiDrection( lineNum, lineUnitLength, [x0,y0,z0],currentArray, k);
        disp(Er)
        disp(ETheta)
        r1 = norm(Er + ETheta);
        rhoMesh(i,j) = r1;
        
    end
end

[X, Y, Z] = sph2cart(phiMesh, thetaMesh, rhoMesh);
figure;
mesh(X,Y,Z);
axis equal



