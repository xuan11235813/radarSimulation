function error = errorBetweenCSTMATLAB( CSTFileName, MatlabMat )


delimiterIn = ' ';
headerlinesIn = 2;
A = importdata(CSTFileName,delimiterIn,headerlinesIn);


dataCST = A.data;
originalTheta = dataCST(:,1);
originalPhi = dataCST(:,2);
originalRCS = dataCST(:,3);

thetaCST = unique(originalTheta);
phiCST = unique(originalPhi);
rhoMeshCST = reshape(originalRCS, [numel(thetaCST), numel(phiCST)]);
thetaMeshCST = (reshape(originalTheta, [numel(thetaCST), numel(phiCST)])/180*pi - pi/2);
phiMeshCST = (reshape(originalPhi, [numel(thetaCST), numel(phiCST)])/180*pi - pi);


[X, Y, Z] = sph2cart(phiMeshCST, thetaMeshCST, rhoMeshCST);

X_ = reshape(X(Z>0), [sum(sum(Z>0))/numel(phiCST), numel(phiCST)]);
Y_ = reshape(Y(Z>0), [sum(sum(Z>0))/numel(phiCST), numel(phiCST)]);
Z_ = reshape(Z(Z>0), [sum(sum(Z>0))/numel(phiCST), numel(phiCST)]);

[phiMeshCST, thetaMeshCST, rhoMeshCST] = cart2sph(X_, Y_, Z_);
phiMeshCST = phiMeshCST';
thetaMeshCST = thetaMeshCST';
rhoMeshCST = rhoMeshCST';

rhoMeshCST = rhoMeshCST/max(rhoMeshCST(:));

dataMatlab = load(MatlabMat);
rhoMeshMatlab = dataMatlab.rhoMesh;
thetaMeshMatlab = dataMatlab.thetaMesh;
phiMeshMatlab = dataMatlab.phiMesh;


rhoMeshMatlab = rhoMeshMatlab/max(rhoMeshMatlab(:));


rhoMeshMatlabStar = zeros(size(rhoMeshCST));
errorMat = zeros(size(rhoMeshCST));
% try to find the indices in matlab model
[height, width] = size(rhoMeshCST);
for i = 1:height
    for j = 1:width
        currentPhiCST = phiMeshCST(i,j);
        currentThetaCST = thetaMeshCST(i,j);
        currentRhoCST = rhoMeshCST(i,j);
        [normalPhi, alphaPhi, previousPhi, ~] = findIndex( phiMeshMatlab, currentPhiCST );
        [normalTheta, alphaTheta, previousTheta, ~] = findIndex(thetaMeshMatlab, currentThetaCST);
        if normalPhi == 0 && normalTheta == 0 
            % indices according to matrix index, not coordinators
            r00 = rhoMeshMatlab(previousPhi, previousTheta);
            r10 = rhoMeshMatlab(previousPhi +1, previousTheta);
            r01 = rhoMeshMatlab(previousPhi, previousTheta +1);
            r11 = rhoMeshMatlab(previousPhi +1, previousTheta +1);
            rStarLeft = r00 * alphaPhi + (1- alphaPhi) * r10;
            rStarRight = r01 * alphaPhi + (1 - alphaPhi) * r11;
            rStar = rStarLeft * alphaTheta + (1 - alphaTheta) * rStarRight;
            rhoMeshMatlabStar(i,j) = rStar;
            errorMat(i,j) = abs(rStar - currentRhoCST);
        end
        
    end
end

error = sum(sum(rhoMeshCST.^2.*errorMat))/sum(sum( rhoMeshCST.^3 ));


