gamma = 5;
lineNum = 480*gamma;
lineUnitLength = 0.00025/gamma;
B0 = 0.01;
k = 418.879 * 6;

length = lineNum * lineUnitLength;

sparkLength = 0.002;
dutyCycle = 0.2;
disk_unregular = generateDisk( ...
    'conductor', ...
    lineUnitLength, ...
    length, ...
    sparkLength, ...
    dutyCycle);
subplot(5,1,5);
plot(disk_unregular);



disk = disk_unregular;
figure;
for i = 0:pi/2:pi/200
    
    currentArray = calculateCurrentWithDisk(...
        disk,...
        B0,...
        i,...
        lineUnitLength,...
        k);
%     currentArray = calculateDipoleCurrent( lineNum, lineUnitLength, 1, k);

    r = 1;
    thetaStep = 0.005;
    thetaArray = 0:thetaStep:2 * pi;

    rhoArray = zeros(1,numel(thetaArray));


    for j = 1:numel(thetaArray)
        theta = thetaArray(j);
        x0 = 0;
        y0 = r * sin(theta);
        z0 = r * cos(theta);
        [Er, ETheta] = calculateMultiDrection( lineNum, lineUnitLength, [x0,y0,z0],currentArray, k);
        r1 = norm(real(Er) + real(ETheta));
        rhoArray(j) = r1;
    end
    
    polarplot(thetaArray,rhoArray)
    pause(0.1);
end

% currentArray = calculateCurrentWithDisk(...
%         disk,...
%         B0,...
%         incidentAngle,...
%         lineUnitLength,...
%         k);
% r = 2;
% thetaStep = 0.01;
% phiStep = 0.01;
% thetaArray = 0:thetaStep:pi/2;
% phiArray  = -pi:phiStep:pi;
% [thetaMesh ,phiMesh] = meshgrid(thetaArray, phiArray);
% 
% [height, width] = size(thetaMesh);
% rhoMesh = zeros(height, width);
% disp(height)
% 
% parfor i = 1:height
%     for j = 1:width
%         theta = thetaMesh(i,j);
%         phi = phiMesh(i,j);
%         x0 = r * cos(theta)*cos(phi);
%         y0 = r * cos(theta)*sin(phi);
%         z0 = r * sin(theta);
%         [Er, ETheta] = calculateMultiDrection( lineNum, lineUnitLength, [x0,y0,z0],currentArray, k);
%         disp(Er)
%         disp(ETheta)
%         r1 = norm(Er + ETheta);
%         rhoMesh(i,j) = r1;
%         
%     end
% end
% 
% [X, Y, Z] = sph2cart(phiMesh, thetaMesh, rhoMesh);
% figure;
% mesh(X,Y,Z);
% axis equal
% 


