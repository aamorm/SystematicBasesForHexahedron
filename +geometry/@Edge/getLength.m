function lengthEdge = getLength(edgeObj)
    % GETLENGTH gives the physical length for an (array) of edges.
    % GETLENGTH(edgeObj) uses the object (or array of objects) as parameter and
    % computes the physical length between the coordinates.

    lengthEdge = zeros(1,length(edgeObj));
    for ii = 1:length(edgeObj)
        lengthEdge(ii) = norm(edgeObj(ii).nodes(1).coordinates - edgeObj(ii).nodes(2).coordinates);
    end

end
