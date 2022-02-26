classdef Mesh < handle
    % This is a class used to store all the references to nodes, edges, faces, elements,
    % materials, and boundary conditions presents in a mesh.

    properties

        % Reference to nodes.
        nodes(:,1) geometry.Node
        % Reference for edges.
        edges(:,1) geometry.Edge
        % Reference for faces.
        faces(:,1) geometry.Face
        % Reference for elements.
        elements(:,1) geometry.Element
        % Reference for the solids in the mesh.
        solids(:,1) geometry.Solid
        % Reference for the boundary conditions in the mesh.
        polyFaces(:,1) geometry.PolyFace

        % Number of DOF present in the mesh.
        numDOF double
        % Settings of the problem where mesh is the domain.
        settingsObj settings.SystemSettings

    end

    methods
        function meshObj = Mesh()
            % This constructor is the default one since the mesh are loaded from
            % memory.

        end
    end

end