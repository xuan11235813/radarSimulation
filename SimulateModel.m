classdef SimulateModel <handle
    properties
        % class
        diskMode
        parameter
        % matrix
        current
        position
        isConduct
        
        % number
        
    end
    methods
        % initialization of simulation model
        function obj = SimulateModel( exampleName )
            disp('initialize simulation model')
            obj.parameter = SimulatePar();
            obj.diskMode = DiskModel(exampleName, obj.parameter.exampleWidth);
            widthLength = obj.diskMode.edgeWidthSize;
            heightLength = obj.diskMode.edgeHeightSize;
            currentHeight = floor(heightLength/obj.parameter.lineUnitWidth);
            currentWidth = floor(widthLength/obj.parameter.lineUnitLength);
            obj.current = zeros(currentHeight, currentWidth);
            obj.isConduct = zeros(currentHeight, currentWidth);
            obj.position =zeros(currentHeight, currentWidth, 3);
            disp('calculate surface current')
            for i =  1:currentHeight
                for j = 1:currentWidth
                    obj.position(i,j,1) = obj.parameter.lineUnitLength * ...
                        ( j - 0.5 ) - widthLength/2;
                    obj.position(i,j,2) = obj.parameter.lineUnitWidth * ...
                        ( i - 0.5 ) - heightLength/2;
                    pos = obj.position(i,j,:);
                    obj.isConduct(i,j) = obj.diskMode.checkConduct(pos(1), pos(2));
                    if obj.isConduct(i,j) == 1
                        obj.current(i,j) = obj.calculateCurrent(pos(1));
                    end
                end
            end
            disp('Done !')
        end
        
        % calculate the surface current
        function value = calculateCurrent(obj, xPosition)
            incidentAngle = obj.parameter.incidentAngle;
            B0 = obj.parameter.B0;
            k = obj.parameter.k;
            miu0 = 4 * pi * 10^(-7);
            lineUnitWidth = obj.parameter.lineUnitWidth;
            Bv = exp(1j * xPosition * sin(incidentAngle)*k)* B0;
            Bvt = Bv * cos(incidentAngle);
            Hvt = Bvt/miu0;
            value = Hvt * lineUnitWidth;
        end
        
        % start simulation
        function startSimulation(obj)
            k = obj.parameter.k;
            r = obj.parameter.r;
            lineUnitLength = obj.parameter.lineUnitLength;
            currentMatrix = obj.current;
            pos = obj.position;
            
            thetaStep = 0.01;
            phiStep = 0.01;
            thetaArray = 0:thetaStep:pi/2;
            phiArray  = -pi:phiStep:pi;
            [thetaMesh ,phiMesh] = meshgrid(thetaArray, phiArray);
            
            [height, width] = size(thetaMesh);
            rhoMesh = zeros(height, width);
            disp(height);
            parfor i  = 1:height
                disp(i);
                for j = 1:width
                    theta = thetaMesh(i,j);
                    phi = phiMesh(i,j);
                    x0 = r * cos(theta)*cos(phi);
                    y0 = r * cos(theta)*sin(phi);
                    z0 = r * sin(theta);
                    [Er, ETheta] = calculateElectricIntensity(...
                        [x0,y0,z0],...
                        currentMatrix, ...
                        k,  ...
                        pos, ...
                        lineUnitLength);
                    r1 = abs(Er + ETheta).^2;
                    r1 = sqrt(sum(r1(:)));
                    rhoMesh(i,j) = r1;
                end
            end
            [X, Y, Z] = sph2cart(phiMesh, thetaMesh, rhoMesh);
            figure;
            mesh(X,Y,Z);
            axis equal
        end
        
    end
    methods(Static)
    end
end