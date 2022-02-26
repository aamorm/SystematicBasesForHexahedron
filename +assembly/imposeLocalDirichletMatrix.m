function [dirichletMatrix] = imposeLocalDirichletMatrix(meshObj, elemObj, matrix)
    % IMPOSELOCALDIRICHLET returns an element matrix where we have set to 1 the diagonal and
    % removed the remaining terms in row and columns.
    % IMPOSELOCALDIRICHLET(meshObj, elemObj, matrix) takes the boundary conditions from the
    % mesh passed as parameter, runs through all the edges and faces from elemObj and
    % apply the Dirichlet boundary conditions (setting to 0 the rows and columns and to
    % one the diagonals where Dirichlet is applied) to the matrix passed as parameter.

    % Counter to check all the dofs.
    currentDOF = 0;
    dirichletMatrix = matrix;

    % We run through all the edges and check if the edge belongs to a Dirichlet
    % boundary condition.
    for indexEdge = 1:length(elemObj.edges)
        polyFaceId = elemObj.edges(indexEdge).polyFaceId;
        lengthDOF = length(elemObj.edges(indexEdge).dof);

        [dirichletMatrix] = checkDirichlet (dirichletMatrix, meshObj, currentDOF, lengthDOF, polyFaceId);
        currentDOF = currentDOF + lengthDOF;
    end

    % The same for the faces.
    for indexFace = 1:length(elemObj.faces)
        polyFaceId = elemObj.faces(indexFace).polyFaceId;
        lengthDOF = length(elemObj.faces(indexFace).dof);

        [dirichletMatrix] = checkDirichlet (dirichletMatrix, meshObj, currentDOF, lengthDOF, polyFaceId);
        currentDOF = currentDOF + lengthDOF;
    end

end

function [dirichletMatrix] = checkDirichlet (dirichletMatrix, meshObj, currentDOF, lengthDOF, polyFaceId)
    % Internal function to check for both entities (edge and face) if we need to apply Dirichlet.

    dirichletString = "PerfectE";
    if (polyFaceId ~= 0)
        if (strcmp(meshObj.polyFaces(polyFaceId).polyFaceType, dirichletString))
            dirichletMatrix = imposeDirichletInRowAndCol(dirichletMatrix, currentDOF, lengthDOF);
        end
    end

end

function [dirichletMatrix] = imposeDirichletInRowAndCol (dirichletMatrix, currentDOF, lengthDOF)
    % Internal function to remove the Dirichlet unknown.

    dirichletMatrix(currentDOF+1:currentDOF+lengthDOF,:) = 0;
    dirichletMatrix(:,currentDOF+1:currentDOF+lengthDOF) = 0;
    dirichletMatrix(currentDOF+1:currentDOF+lengthDOF,currentDOF+1:currentDOF+lengthDOF) = eye(lengthDOF);

end