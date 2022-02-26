function [jacobianEdge, originCoordinate] = getJacobian(edgeObj)
    % GETJACOBIAN returns the mapping between 1D to 3D points for
    % the edge passed as parameter.

    jacobianEdge = edgeObj.nodes(2).coordinates - edgeObj.nodes(1).coordinates;
    originCoordinate = edgeObj.nodes(1).coordinates;