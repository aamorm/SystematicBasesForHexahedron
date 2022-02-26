function [FEMatrices] = getGlobalMatrices(meshObj)
    % GETGLOBALMATRICES computes the stiffness and mass matrices for the
    % generalized eigenvalue problem.
    % GETGLOBALMATRICES(meshObj) takes the mesh passed as parameter and
    % returns a structure with two fields: stiffness and mass.

    % Preallocation of sparse matrices.
    nonZeros = meshObj.getNNZ();
    irnValues = zeros(nonZeros,1);
    jcnValues = zeros(nonZeros,1);
    aValues = zeros(nonZeros,1);
    a2Values = zeros(nonZeros,1);
    sparseIndex = 0;


    % We load here the basis functions computed before.
    refBasesObj = bases.SystematicBases();
    percentage = round(length(meshObj.elements)/10);

    for elemIndex = 1:length(meshObj.elements)

        % We obtain the different objects that represent the object and the
        % material.
        currentElemObj = meshObj.elements(elemIndex);
        solidObj = meshObj.solids(currentElemObj.solidId);
        % We compute the straight Jacobian Matrix.
        jacobianMatrix = currentElemObj.computeJacobianMatrix();

        % We compute the stiffness and mass matrices per element.
        stiffElementMatrix = assembly.getStiffMatrix(refBasesObj, currentElemObj, jacobianMatrix, solidObj.materialObj.muRelative);
        massElementMatrix = assembly.getMassMatrix(refBasesObj, currentElemObj, jacobianMatrix, solidObj.materialObj.epsilonRelative);

        % We get the whole array of dofs to perform the finite element assembly.
        dofIndices = currentElemObj.getDOF();

        % It is stored columnwise (irn are rows, jcn are columns).
        irnValues (sparseIndex+1:sparseIndex+length(dofIndices)^2) = reshape(dofIndices*ones(1,length(dofIndices)),[],1);
        jcnValues (sparseIndex+1:sparseIndex+length(dofIndices)^2) = reshape(ones(length(dofIndices),1)*dofIndices',[],1);

        % We impose the dirichlet boundary conditions to each element matrix.
        localDirichletMatrix = assembly.imposeLocalDirichletMatrix (meshObj, currentElemObj, stiffElementMatrix);
        aValues(sparseIndex+1:sparseIndex+length(dofIndices)^2) = reshape(localDirichletMatrix,[],1);

        localDirichletMatrix = assembly.imposeLocalDirichletMatrix (meshObj, currentElemObj, massElementMatrix);
        a2Values(sparseIndex+1:sparseIndex+length(dofIndices)^2) = reshape(localDirichletMatrix,[],1);

        % To help with sparse indexing.
        sparseIndex = sparseIndex + length(dofIndices)^2;

        % For displaying purposes.
        if (elemIndex/percentage == round(elemIndex/percentage))
            disp([num2str(round(elemIndex/percentage)*10),  '% assembly done'])
        end
    end

    % We perform here the finite element assembly.
    FEMatrices.stiffness = sparse(irnValues(1:sparseIndex), jcnValues(1:sparseIndex), aValues(1:sparseIndex));
    FEMatrices.mass = sparse(irnValues(1:sparseIndex), jcnValues(1:sparseIndex), a2Values(1:sparseIndex));
