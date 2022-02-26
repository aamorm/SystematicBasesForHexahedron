classdef Material < handle

    % Class to represent the material of the electromagnetic problems.
    % Inhomogeneous and anisotropic material is supported (is stored in
    % the parameters and called with evaluateMaterial).

    properties
        % Name for the material.
        name char
        % Reference to the material property object.
        epsilonRelative settings.MaterialProperty
        % Reference to the material property object.
        muRelative settings.MaterialProperty
        % Reference to the material property object.
        sigma settings.MaterialProperty

    end

    methods
        function materialObject = Material()
            % Default constructor since everything is loaded from the .mat
            % container.
        end
    end

end