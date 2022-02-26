classdef Solid < handle
    % Class used to store the solids (materials) present in the problem.

    properties
        % Name for the Solid.
        name
        % Identifiers for the elements (or faces in 2D) which belong to the Solid.
        elements(:,1) double
        % Material of the solid
        materialObj settings.Material
    end

    methods
        function solidObject = Solid()
            % This constructor is the default one since the mesh (and solids
            % associated) are loaded from memory.
        end
    end

end