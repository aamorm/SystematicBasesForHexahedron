function afterDOF = generateDOF(faceObj, currentDOF)
    % GENERATEDOF - returns the last number of dof assigned.
    % GENERATEDOF(meshObj) generates four dofs per each face.

    sizeDOF = 2*faceObj.pOrder*(faceObj.pOrder-1);
    faceObj.dof = currentDOF+1:currentDOF+sizeDOF;
    afterDOF = currentDOF+sizeDOF;
