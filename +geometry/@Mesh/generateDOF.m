function currentDOF = generateDOF(meshObj)
    % GENERATEDOF - returns the final number of DOF that are stored
    % inside the mesh.
    % GENERATEDOF(meshObj) runs through all the entities (edges, faces and elements)
    % in the mesh to provide a unique identifier for each dof in each entity.

    currentDOF = 0;

    for ii = 1:length(meshObj.edges)
        currentDOF = meshObj.edges(ii).generateDOF(currentDOF);
    end

    for ii = 1:length(meshObj.faces)
        currentDOF = meshObj.faces(ii).generateDOF(currentDOF);
    end

    for ii = 1:length(meshObj.elements)
        currentDOF = meshObj.elements(ii).generateVolumeDOF(currentDOF);
    end

    meshObj.numDOF = currentDOF;
