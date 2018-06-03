function disk = siegenDiskRotation(outer, inner, angleOuter, angleInner)

disk = uint8(zeros(6000,6000,3));
readyToPasteOuter = refineImage(imrotate(outer, angleOuter/pi * 180));
readyToPasteInner = refineImage(imrotate(inner, angleInner/pi * 180));

[height, ~, ~] = size(readyToPasteOuter);
centerOuter = floor(height/2);

[height, ~, ~] = size(readyToPasteInner);
centerInner = floor(height/2);

disk(:,:,1) = disk(:,:,1) + readyToPasteOuter(centerOuter - 2999:centerOuter + 3000,centerOuter - 2999:centerOuter + 3000); 
disk(:,:,1) = disk(:,:,1) + readyToPasteInner(centerInner - 2999:centerInner + 3000,centerInner - 2999:centerInner + 3000); 
disk = refineImage(disk);
