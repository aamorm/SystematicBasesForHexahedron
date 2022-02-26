function allCoordinates = getAllCoordinates(elemObj)
    % GETALLCOORDINATES gets the physical coordinates of all the nodes that
    % compose the element.
    % GETALLCOORDINATES(elemObj) returns the physical coordinates of all the
    % nodes.

    allCoordinates = zeros(8,3);

    for ii = 1:8
        allCoordinates(ii,:) = elemObj.nodes(ii).coordinates;
    end