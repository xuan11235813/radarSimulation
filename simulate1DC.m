gamma = 10;
lineNum = 480*gamma;
lineUnitLength = 0.00025/gamma;
B0 = 0.01;
k = 418.879;

length = lineNum * lineUnitLength;

sparkLength = 0.002;
dutyCycle = 0.2;
disk_unregular = generateDisk( ...
    'randomConductSpark', ...
    lineUnitLength, ...
    length, ...
    sparkLength, ...
    dutyCycle);
figure(2)
plot(disk_unregular);



disk = disk_unregular;

for i = [1, 3, 6]
    currentArray = calculateCurrentWithDisk(...
        disk,...
        B0,...
        pi/3,...
        lineUnitLength,...
        k * i);

    r = 20;
    thetaStep = 0.005;
    thetaArray = 0:thetaStep:2 * pi;

    rhoArray = zeros(1,numel(thetaArray));


    for j = 1:numel(thetaArray)
        theta = thetaArray(j);
        x0 = 0;
        y0 = r * sin(theta);
        z0 = r * cos(theta);
        [Er, ETheta] = calculateMultiDrection( lineNum, lineUnitLength, [x0,y0,z0],currentArray, k * i);
        r1 = norm(abs(Er + ETheta));
        rhoArray(j) = r1;
    end
    
    figure(i)
    polarplot(thetaArray,rhoArray)
    pause(0.1);
    
end

