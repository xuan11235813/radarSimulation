function simulateWithParameter(...
    startAngle,...
    endAngle,...
    angleStep,...
    lineNum,...
    lineUnitLength,...
    B0,...
    sparkLength,...
    dutyCycle,...
    diskMode,...
    r,...
    k)

startAngle = startAngle/180 * pi;
endAngle = endAngle/180 * pi;
angleStep = angleStep/180* pi;
length = lineUnitLength * lineNum;

disk = generateDisk( ...
    diskMode, ...
    lineUnitLength, ...
    length, ...
    sparkLength, ...
    dutyCycle);
figure;
plot(disk);
title('disk')

figure;
for i = startAngle:angleStep:endAngle
    currentArray = calculateCurrentWithDisk(...
        disk,...
        B0,...
        i,...
        lineUnitLength,...
        k);


    thetaStep = 0.005;
    thetaArray = -pi/2:thetaStep:pi/2;

    rhoArray = zeros(1,numel(thetaArray));


    parfor j = 1:numel(thetaArray)
        theta = thetaArray(j);
        phi = 0;
        x0 = r * cos(theta)*cos(phi);
        y0 = r * cos(theta)*sin(phi);
        z0 = r * sin(theta);
        [Er, ETheta] = calculateMultiDrection( lineNum, lineUnitLength, [x0,y0,z0],currentArray, k);
        r1 = norm(Er + ETheta);
        rhoArray(j) = r1;
    end
    
    polarplot(thetaArray,rhoArray)
    pause(0.1);
end