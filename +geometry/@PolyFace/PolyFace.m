classdef PolyFace < handle
    % Class used to store the boundary conditions present in the problem.

    properties
        % Identifier for the PolyFace
        id double
        % Name for the PolyFace.
        name
        % String which define the type of the PolyFace
        polyFaceType
        % Identifiers for the faces which belong to the PolyFace.
        faces(:,1) double

    end

    methods
        function polyFaceObject = PolyFace()
            % This constructor is the default one since the mesh (and poly faces
            % associated) are loaded from memory.

        end
    end

end