function [avgLength, maxLength, minLength] = getLengthStatistics(meshObj)
    % GETLENGTHSTATISTICS gets the average, maximum and minimum lengths of the
    % edges in the mesh.
    % GETLENGTHSTATISTICS(meshObj) runs through all the edges in the mesh passed
    % as parameter and returns the average, maximum and minimum lengths.

    lengthEdges = meshObj.edges.getLength();

    avgLength = mean(lengthEdges);
    maxLength = max(lengthEdges);
    minLength = min(lengthEdges);