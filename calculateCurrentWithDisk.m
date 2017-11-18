function current = calculateCurrentWithDisk(...
    disk,...
    B0,...
    incidentAngle,...
    unitLength,...
    k)


current = zeros(numel(disk),1);
miu0 = 4 * pi * 10^(-7);
for i = 1:numel(disk)
    Bv = exp(1j * (i - 0.5) * unitLength * sin(incidentAngle)*k)* B0;
    Bvt = Bv * cos(incidentAngle);
    Hvt = Bvt/miu0;
    Hmt = Hvt * (1 - disk(i));
    current(i) = (Hvt - Hmt);
end