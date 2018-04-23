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
        
        % theta step
        thetaStep
        % phi step
        phiStep
    end
    methods
        function obj = SimulatePar()
            
            obj.incidentAngle = 0;
            %obj.exampleWidth = 0.006048;
            %obj.exampleWidth = 0.1791;
            %obj.exampleWidth = 0.1791;
            obj.exampleWidth = 0.02;
            obj.lineUnitLength = 0.0001;
            obj.lineUnitWidth = obj.lineUnitLength/12;
            if obj.lineUnitWidth <= 2e-7
                obj.lineUnitWidth = 2e-7;
            end
            if obj.lineUnitLength/obj.lineUnitWidth <= 8
                disp('inaccurate simulation')
            end
            obj.r = 20;
            obj.k = 1256.637;
            obj.B0 = 1e-9;
            obj.E0 = obj.B0/sqrt( 8.854 * 10^-12 * 4 * pi* 10 ^ -7);
            obj.R = -1 * 0.01;
            
            obj.thetaStep = pi/(2* 35);
            obj.phiStep = pi/(2* 35);
        end
    end
    
end