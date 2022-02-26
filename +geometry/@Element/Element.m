classdef Element < handle
    % Class which represents the element in a mesh.  It stores the reference to
    % all the entities (nodes, edges, faces) which constitute the element.

    properties

        % Nodes which compose the element
        nodes geometry.Node
        % Edges which compose the element
        edges geometry.Edge
        % Faces which compose the element
        faces geometry.Face

        % Array of interior dofs.
        volumeDof double
        % Order of the interior element.
        pOrder double
        % Identifier of the solid (material) which this element belongs to.
        solidId = 0;
        % Unique identifier in the mesh.
        id double;

    end

    methods
        function elemObj = Element(varargin)
            % Constructor of the elements. Actually, we use it only for
            % the reference element since the mesh elements are already
            % stored in meshesHalfFilledTAP2021.

            import geometry.*;

            if (nargin > 0)
                if (strcmp(varargin{1},'referenceElement'))
                    % Coordinates of the reference element.
                    coordinates = [0 0 0; 1 0 0; 1 1 0; 0 1 0; 0 0 1; 1 0 1; 1 1 1; 0 1 1];
                    numNodes = 8;
                    numEdges = 12;
                    numFaces = 6;

                    % Initialization.
                    objNodes(numNodes) = Node;
                    objEdges(numEdges) = Edge;
                    objFaces(numFaces) = Face;

                    % Creation of the nodes from the coordinates.
                    for ii = 1:numNodes
                        objNodes(ii) = Node(coordinates(ii,:),ii);
                    end
                    % We follow the ordering given by getEdgeByLocalNodes.
                    for ii = 1:numEdges
                        edgeByLocalNodes = Element.getEdgeByLocalNodes(ii);
                        objEdges(ii) = Edge(objNodes(edgeByLocalNodes), ii);
                    end
                    % We follow the ordering given by getFaceByLocalEdges.
                    for ii = 1:numFaces
                        faceByLocalEdges = Element.getFaceByLocalEdges(ii);
                        objFaces(ii) = Face(objEdges(faceByLocalEdges), ii);
                    end
                    % Assignation
                    elemObj.nodes = objNodes;
                    elemObj.edges = objEdges;
                    elemObj.faces = objFaces;
                end
            end
        end
    end

    methods (Static)
        function edgeByLocalNodes = getEdgeByLocalNodes(edgeNumber)
            % GETEDGEBYLOCALNODES This method gives the relation of each edge in
            % the element with the nodes of the element.
            % GETEDGEBYLOCALNODES(edgeNumber) only returns the nodes
            % related to the edge specified in the parameter list.

            edgesByLocalNodes = zeros(12,2);
            edgesByLocalNodes(1,:) = [1 2];
            edgesByLocalNodes(2,:) = [2 3];
            edgesByLocalNodes(3,:) = [4 3];
            edgesByLocalNodes(4,:) = [1 4];
            edgesByLocalNodes(5,:) = [5 6];
            edgesByLocalNodes(6,:) = [6 7];
            edgesByLocalNodes(7,:) = [8 7];
            edgesByLocalNodes(8,:) = [5 8];
            edgesByLocalNodes(9,:) = [1 5];
            edgesByLocalNodes(10,:) = [2 6];
            edgesByLocalNodes(11,:) = [3 7];
            edgesByLocalNodes(12,:) = [4 8];

            edgeByLocalNodes = edgesByLocalNodes(edgeNumber,:);
        end
        function faceByLocalEdges = getFaceByLocalEdges(faceNumber)
            % GETFACEBYLOCALEDGES This method returns the relation of each face
            % in the element with the edges of the element.
            % GETFACEBYLOCALEDGES(faceNumber) only returns the edges
            % related to the face specified in the parameter list.

            facesByLocalEdges = zeros(6,4);
            facesByLocalEdges(1,:) = [1 2 3 4];
            facesByLocalEdges(2,:) = [5 6 7 8];
            facesByLocalEdges(3,:) = [1 10 5 9];
            facesByLocalEdges(4,:) = [2 11 6 10];
            facesByLocalEdges(5,:) = [3 11 7 12];
            facesByLocalEdges(6,:) = [4 12 8 9];

            faceByLocalEdges = facesByLocalEdges(faceNumber,:);
        end
    end


end