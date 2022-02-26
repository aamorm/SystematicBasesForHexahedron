classdef SystemSettings < handle

    % Class to represent settings of the problem (order of the basis functions, materials, frequency and curved tailored surfaces if present)

    properties
        % Order present in the mesh
        % This would be an array of #elements x #order for each entity if necessary.
        % Matlab is not really good at dealing with different types of variables so let's restrict to double
        pOrder double
        % Electromagnetic parameters of the materials
        materials settings.Material
    end

    methods
        function systemSettingsObject = SystemSettings()
            % Default constructor since everything is loaded from the .mat
            % container.
        end
    end

end