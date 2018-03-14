classdef SimulatePar < handle
    % define the parameters
    properties
        % incident angle (degree)
        incidentAngle
        
        % example width (meter)
        exampleWidth
        
        % simulate line (meter)
        lineUnitWidth
        lineUnitLength
        
        % incident electromagnatic intensity, magatic part (Tesla)
        B0
        
        % incident electromagnatic intensity, electric part (N/C)
        E0
        
        % distance (meter)
        r
        
        % wavenumber
        k
        
        % R reflective
        R
    end
    methods
        function obj = SimulatePar()
            
            obj.incidentAngle = 0;
            %obj.exampleWidth = 0.006048;
            obj.exampleWidth = 0.1791;
            obj.lineUnitLength = 0.0002;
            obj.lineUnitWidth = obj.lineUnitLength/20;
            if obj.lineUnitWidth <= 2e-6
                obj.lineUnitWidth = 2e-6;
            end
            if obj.lineUnitLength/obj.lineUnitWidth <= 8
                disp('inaccurate simulation')
            end
            obj.r = 1;
            obj.k = 1256.637;
            obj.B0 = 1e-9;
            obj.E0 = obj.B0/sqrt( 8.854 * 10^-12 * 4 * pi* 10 ^ -7);
            obj.R = -1 * 0.01;
        end
    end
    
end