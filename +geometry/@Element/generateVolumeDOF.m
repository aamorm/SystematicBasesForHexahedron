function afterDOF = generateVolumeDOF(elemObj, currentDOF)
    % GENERATEVOLUMEDOF - returns the last number of dof assigned.
    % GENERATEVOLUMEDOF(meshObj) generates six dofs per element.

    sizeDOF = 3*elemObj.pOrder*(elemObj.pOrder-1)^2;

    elemObj.volumeDof = currentDOF+1:currentDOF+sizeDOF;
    afterDOF = currentDOF+sizeDOF;
