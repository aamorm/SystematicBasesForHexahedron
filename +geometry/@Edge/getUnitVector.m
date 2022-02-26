function unitVector = getUnitVector(edgeObj)
    % GETLENGTH gives the unit vector for an (array) of edges.
    % GETLENGTH(edgeObj) uses the object (or array of objects) as parameter and
    % computes the unit vector from the coordinates.

    numDimensions = length(edgeObj(1).nodes(1).coordinates);
    unitVector = zeros(numDimensions, length(edgeObj));
    for ii = 1:length(edgeObj)
        unitVector(:,ii) = edgeObj(ii).nodes(2).coordinates - edgeObj(ii).nodes(1).coordinates;
        unitVector(:,ii) = unitVector(:,ii)/norm(unitVector(:,ii));
    end

end
