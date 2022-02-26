classdef MaterialProperty < handle

    % Class to represent the material of the electromagnetic problems.
    % Inhomogeneous and anisotropic material is supported (is stored in
    % the parameters and called with evaluateProperty).

    properties
        % This might be a double, a symbolic expression or a math.Polynomial.
        property
    end

    methods
        function materialPropertyObject = MaterialProperty()
            % Default constructor since everything is loaded from the .mat
            % container.
        end
    end

end