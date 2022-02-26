classdef Edge < handle
    % This class represents an edge of the mesh defined by two points. They are
    % only defined once in the mesh and the elements store references to all
    % their edges.

    properties

        % Vertex objects that compose the edge
        nodes geometry.Node

        % Local order of the entity.
        pOrder double

        % Array of numbers which represent the numbering for FEM matrices (DOF).
        dof(:,1) double

        % Unique identifier in the global mesh
        id double

        % Identifier of the boundary condition for polyFaces
        polyFaceId double

    end

    methods
        function edgeObject = Edge(nodes, id)
            % Constructor of the edge objects.

            if (nargin > 0)
                edgeObject.nodes = nodes;
                edgeObject.id = id;
            end
        end
    end

end