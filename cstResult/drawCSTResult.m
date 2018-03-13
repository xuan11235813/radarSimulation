function drawCSTResult(fileName)
delimiterIn = ' ';
headerlinesIn = 2;
A = importdata(fileName,delimiterIn,headerlinesIn);


data = A.data;
originalTheta = data(:,1);
originalPhi = data(:,2);
originalRCS = data(:,3);

theta = unique(originalTheta);
phi = unique(originalPhi);

thetaMesh = reshape(originalTheta, [numel(theta), numel(phi)])/180*pi - pi/2;
phiMesh = reshape(originalPhi, [numel(theta), numel(phi)])/180*pi - pi;
rhoMesh = reshape(originalRCS, [numel(theta), numel(phi)]);


[X, Y, Z] = sph2cart(phiMesh, thetaMesh, rhoMesh);

figure;
mesh(X,Y,Z);
axis equal

X_ = reshape(X(Z>0), [sum(sum(Z>0))/numel(phi), numel(phi)]);
Y_ = reshape(Y(Z>0), [sum(sum(Z>0))/numel(phi), numel(phi)]);
Z_ = reshape(Z(Z>0), [sum(sum(Z>0))/numel(phi), numel(phi)]);


figure;
mesh(X_,Y_,Z_);
axis equal