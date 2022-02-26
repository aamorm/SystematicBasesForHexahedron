function afterDOF = generateDOF(edgeObj, currentDOF)
    % GENERATEDOF - returns the last number of dof assigned.
    % GENERATEDOF(meshObj) generates two dofs per each edge.

    % For edges, the number of DOF is equal to their order.
    edgeObj.dof = currentDOF+1:currentDOF+edgeObj.pOrder;
    afterDOF = currentDOF+edgeObj.pOrder;
