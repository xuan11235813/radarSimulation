function [Er, ETheta] = calculateElectricIntensityPar(...
    targetPointCood, ...
    currentMatrix, ...
    k,  ...
    position, ...
    lineUnitLength)

    [height, ~, ~] = size(position);
    step = floor(height/4);

    ErArray  = ones(4,1,3);
    EThetaArray = ones(4,1,3);
    
    
    
%     positionBlock1 = position(1:step, :, :);
%     currentMatrixBlock1 = currentMatrix( 1:step, : );
%     positionBlock2 = position(step+1:step *2, :, :);
%     currentMatrixBlock2 = currentMatrix( step +1:step*2, : );
%     positionBlock3 = position(step *2+1:step *3, :, :);
%     currentMatrixBlock3 = currentMatrix( step *2 +1:step*3, : );
%     positionBlock4 = position(step *3+1:height, :, :);
%     currentMatrixBlock4 = currentMatrix( step *3 +1:height, : );
    

    parfor i = 1:4
        if i <=3
            
            positionBlock = position((i-1)*step +1:i*step, :,:);
            currentMatrixBlock = currentMatrix((i-1)*step +1:i*step,:);
        else
            positionBlock = position((i-1)*step +1:height,:,:);
            currentMatrixBlock = currentMatrix((i-1)*step +1:height, :);
            
        end
%         if i == 1
%             positionBlock = positionBlock1;
%             currentMatrixBlock = currentMatrixBlock1;
%         elseif i == 2
%             positionBlock = positionBlock2;
%             currentMatrixBlock = currentMatrixBlock2;
%         elseif i == 3
%             positionBlock = positionBlock3;
%             currentMatrixBlock = currentMatrixBlock3;
%         else
%             positionBlock = positionBlock4;
%             currentMatrixBlock = currentMatrixBlock4;
%         end
        [er, etheta] = calculateElectricIntensity(targetPointCood, currentMatrixBlock, ...
            k, positionBlock, lineUnitLength);
        ErArray(i,1,:) = er;
        EThetaArray(i, 1,:) = etheta;
    end
    
    Er = sum(ErArray);
    ETheta = sum(EThetaArray);
    