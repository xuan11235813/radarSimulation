diskOuter = imread('siegenDiskOuter.png');
diskInner = imread('siegenDiskInner.png');

samplingTimeSlot = 0.001;
innerAngleW = 7;
outerAngleW = 6;

timeStart = 0;
timeEnd = 1;
result = zeros(numel(timeStart:samplingTimeSlot:timeEnd),1);
for i = timeStart:samplingTimeSlot:timeEnd
    innerAngle = innerAngleW * i;
    outerAngle = outerAngleW * i;
    disk = siegenDiskRotation(diskOuter, diskInner, outerAngle, innerAngle);
    imwrite(disk, 'processImage.png');
    sim = SimulateModel('processImage.png');
    result(i) = sim.simulateOnePoint();   
end
