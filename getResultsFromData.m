function getResultsFromData( dataName )

data = load(dataName);
parameter = SimulatePar();
thetaStep = parameter.thetaStep;
phiStep = parameter.phiStep;
currentMatrix = data.currentMatrix;
thetaMesh = data.thetaMesh;
rhoMesh = data.rhoMesh * thetaStep * phiStep/(4* pi);
phiMesh = data.phiMesh;

[X, Y, Z] = sph2cart(phiMesh, thetaMesh, rhoMesh);
figure;
zMax = max(Z(:));
mesh(X/zMax,Y/zMax,Z/zMax);
axis equal;

figure;
mesh(X,Y,Z)


figure;
mesh(real(currentMatrix));


