gamma = 5;
lineNum = 480*gamma;
lineUnitLength = 0.00025/gamma;
B0 = 0.01;
k = 418.879 * 6;
angle = 0;
length = lineNum * lineUnitLength;

sparkLength = 0.002;
dutyCycle = 0.2;
disk_unregular = generateDisk( ...
    'randomConductSpark', ...
    lineUnitLength, ...
    length, ...
    sparkLength, ...
    dutyCycle);
figure(1)
plot(disk_unregular);



disk = disk_unregular;



currentArray = calculateCurrentWithDisk(...
    disk,...
    B0,...
    angle,...
    lineUnitLength,...
    k);

r = 20;
thetaStep = 0.005;
thetaArray = 0:thetaStep:2 * pi;

rhoArray = zeros(1,numel(thetaArray));


for j = 1:numel(thetaArray)
    theta = thetaArray(j);
    x0 = 0;
    y0 = r * sin(theta);
    z0 = r * cos(theta);
    [Er, ETheta] = calculateMultiDrection( lineNum, lineUnitLength, [x0,y0,z0],currentArray, k );
    r1 = norm(abs(Er + ETheta));
    rhoArray(j) = r1;
end

figure(2);
polarplot(thetaArray,rhoArray)


sparkLength = 0.001;
dutyCycle = 0.2;
disk_unregular = generateDisk( ...
    'randomConductSpark', ...
    lineUnitLength, ...
    length, ...
    sparkLength, ...
    dutyCycle);
figure(3)
plot(disk_unregular);



disk = disk_unregular;



currentArray = calculateCurrentWithDisk(...
    disk,...
    B0,...
    angle,...
    lineUnitLength,...
    k);

r = 20;
thetaStep = 0.005;
thetaArray = 0:thetaStep:2 * pi;

rhoArray = zeros(1,numel(thetaArray));


for j = 1:numel(thetaArray)
    theta = thetaArray(j);
    x0 = 0;
    y0 = r * sin(theta);
    z0 = r * cos(theta);
    [Er, ETheta] = calculateMultiDrection( lineNum, lineUnitLength, [x0,y0,z0],currentArray, k );
    r1 = norm(abs(Er + ETheta));
    rhoArray(j) = r1;
end

figure(4);
polarplot(thetaArray,rhoArray)


