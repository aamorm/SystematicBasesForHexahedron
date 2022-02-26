classdef Node < handle
    % Class used to store the coordinates and the identifiers of the node in the mesh.

    properties
        % Physical coordinates for the point.
        % It is a double array of 3 dimensions.
        coordinates(:,1) double

        % Identifier in the global mesh
        id double

        % Boundary condition from polyFaces
        polyFaceId double
    end

    methods
        function nodeObject = Node(coordinates, id)
            % Constructor of the node objects.
            if (nargin > 0)
                nodeObject.coordinates = coordinates;
                nodeObject.id = id;
                nodeObject.polyFaceId = 0;
            end
        end
    end

end