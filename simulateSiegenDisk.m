
diskOuter = imread('siegenDiskOuter.png');
diskInner = imread('siegenDiskInner.png');

disk = siegenDiskRotation(diskOuter, diskInner, pi/2, -pi/2);
imwrite(disk, 'siegenDiskO90Im90.png');

sim = SimulateModel('siegenDiskO90Im90.png');

sim.startSimulation();