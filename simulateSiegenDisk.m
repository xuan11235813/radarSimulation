
diskOuter = imread('siegenDiskOuter.png');
diskInner = imread('siegenDiskInner.png');
simulateLength = 25200;
load('resultOnePoint')
start = 1;
resultNew = zeros(simulateLength,1);

N = numel(result);
for i = 1:N
    resultNew(i) = result(i);
end

for i = simulateLength:-1:1
    if resultNew(i) ~= 0
        start = i + 1;
        break;
    end
end



result = resultNew;

innerStep = 0.1/180 *pi;
outerStep = - innerStep/7*6;


for i = start:simulateLength
    innerAngle = innerStep * (1-i);
    outerAngle = outerStep * (i-1);
    disk = siegenDiskRotation(diskOuter, diskInner, outerAngle, innerAngle);
    if i == start
        imwrite(disk, 'siegenDiskRun.png');
        sim = SimulateModel('siegenDiskRun.png');
    else
        sim.renewImage(uint8(disk));
    end
    result(i) = sim.simulateOnePoint();
    disp(strcat(num2str(i),': ',num2str(result(i))))
    if mod(i,100) == 0
        save resultOnePoint result 
    end
end

% disk = siegenDiskRotation(diskOuter, diskInner, pi/2, -pi/2);
% imwrite(disk, 'siegenDiskO90Im90.png');

% sim = SimulateModel('siegenDiskO90Im90.png');
% 
% sim.startSimulation();