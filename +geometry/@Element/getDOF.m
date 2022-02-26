function dof = getDOF(elemObj)
    % GETDOF returns all the dofs within an element
    % GETDOF(elemObj) takes the object as parameter and gets the
    % list of dofs for edges, faces and volume following the
    % order within the element.

    dof = zeros (54,1);
    indexDOF = 0;
    for indexEdge = 1:length(elemObj.edges)
        dof(indexDOF+1:indexDOF+length(elemObj.edges(indexEdge).dof)) = elemObj.edges(indexEdge).dof;
        indexDOF = indexDOF + length(elemObj.edges(indexEdge).dof);
    end
    for indexFace = 1:length(elemObj.faces)
        dof(indexDOF+1:indexDOF+length(elemObj.faces(indexFace).dof)) = elemObj.faces(indexFace).dof;
        indexDOF = indexDOF + length(elemObj.faces(indexFace).dof);
    end
    dof (indexDOF+1:indexDOF+length(elemObj.volumeDof)) = elemObj.volumeDof;
    indexDOF = indexDOF+length(elemObj.volumeDof);

    dof = dof(1:indexDOF);