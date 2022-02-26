function jacobMatrix = computeJacobianMatrix(elemObj)
    % COMPUTEJACOBIANMATRIX returns the jacobian matrix for straight hexahedra.
    % COMPUTEJACOBIANMATRIX(elemObj) uses the object passed as parameter and
    % gets the jacobian matrix that represents the mapping between the
    % reference element defined in the constructor of element and
    % the real element passed as parameter.

    verticesElement = elemObj.getAllCoordinates();
    jacobMatrix = [ verticesElement(2,:) - verticesElement(1,:)
                    verticesElement(4,:) - verticesElement(1,:)
                    verticesElement(5,:) - verticesElement(1,:)];

end