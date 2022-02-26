classdef Face < handle
    % This class is used to represent a face in the mesh. They are only defined
    % once in the mesh and the elements store references to all their faces.

    properties

        % Handles to the edge objects which compose the face.
        edges(:,1) geometry.Edge

        % Local order of the entity.
        pOrder double

        % Array of numbers which represent the numbering for
        % FEM matrices (DOF).
        dof(:,1) double

        % Identifier in the global mesh
        id double

        % Identifier of the boundary condition for polyFaces
        polyFaceId double

    end

    methods
        function faceObject = Face(edges,id)
            % Constructor of the face objects.

            if (nargin > 0)
                faceObject.edges = edges;
                faceObject.id = id;
            end
        end
    end

end