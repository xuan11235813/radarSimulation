classdef DiskModel <handle
    % (0,0) at the left-upper corner
    
    properties
        % number
        edgeSize
        edgeWidthSize
        edgeHeightSize
        xOrigin
        yOrigin
        width
        height
        % matrix
        conductChannel
        dielectricChannel
    end
    
    methods
        function obj = DiskModel( exampleName, edgeWidthSize)
            I = imread(exampleName);
            obj.conductChannel = I(:,:,1);
            obj.dielectricChannel = I(:,:,2);
            obj.edgeWidthSize = edgeWidthSize;
            obj.edgeSize = edgeWidthSize;
            [height, width] = size(obj.conductChannel);
            obj.edgeHeightSize = height/width * edgeWidthSize;
            obj.width = width;
            obj.height = height;
            obj.xOrigin = width/2;
            obj.yOrigin = height/2;
        end
        
        function isConduct = checkConduct(obj, xCoord, yCoord )
            % 1 for conduct
            % -1 for dielectric
            % 0 for no material
            isConduct = 0;
            if (abs(xCoord) <= obj.edgeSize/2) && ...
                    (abs(yCoord) <= obj.edgeSize/2)
                xPixel = floor((xCoord/obj.edgeWidthSize) * obj.width + obj.xOrigin);
                yPixel = floor((yCoord/obj.edgeWidthSize) * obj.width + obj.yOrigin);
                if xPixel > 0 && yPixel > 0 && xPixel <=obj.width && yPixel <= obj.height
                    conductPar = double(obj.conductChannel(yPixel, xPixel));
                    dielectricPar = double(obj.dielectricChannel(yPixel, xPixel));
                    if conductPar >= 128 || dielectricPar < 200
                        isConduct = 1;
                    else
                        isConduct = -1;
                    end
                end
            end
        end
    end
    
    methods (Static)
    end
end