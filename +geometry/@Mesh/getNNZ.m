function nonZeros = getNNZ(meshObj)
    % GETNNZ returns an upper bound for the number of non-zeros
    % of a given problem.
    % GETNNZ(meshObj) takes the mesh and runs through all the elements
    % counting the number of dofs associated to the element.

    nonZerosArray = zeros(meshObj.numDOF,1);

    for ii = 1:length(meshObj.elements)
        dofElement = meshObj.elements(ii).getDOF();
        nonZerosArray (dofElement) = nonZerosArray(dofElement) + length(dofElement);
    end
    nonZeros = sum(nonZerosArray);


