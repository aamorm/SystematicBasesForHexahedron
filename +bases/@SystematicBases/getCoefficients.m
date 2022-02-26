function coefficients = getCoefficients (sysBasesObj)
    % GETCOEFFICIENTS Evaluates numerically the dofs in (6), (7), and (8) and
    % obtains the coefficients of the polynomials contained in the mixed-order
    % curl-conforming space through the dual basis imposition of these dofs.
    % GETCOEFFICIENTS(sysBasesObj) takes an object of the SystematicBases class
    % to provide the linear combination of the polynomials of the space.
    % The result is shown in table II.
    % See also GETPOLYNOMIALS, EVALUATEEDGEDOF, EVALUATEFACEDOF, EVALUATEVOLUMEDOF.

    % We use here always the reference element (it could also be done for the real element).
    elemObj = sysBasesObj.refElement;
    lengthBases = size(sysBasesObj.polyAllFunctions,1);
    lhsMatrixGiMon = zeros(lengthBases);

    % For all the polynomials within the space...
    for indexPolynomial = 1:lengthBases
        % We get the polynomial representation (faster than symbolic variables).
        polynomialToEvaluate = sysBasesObj.polyAllFunctions(indexPolynomial, :);
        dofCounter = 0;
        % We apply (6) at each edge.
        for indexEdge = 1:length(elemObj.edges)
            edgeObj = elemObj.edges(indexEdge);
            edgeDOFs = sysBasesObj.evaluateEdgeDOF(edgeObj, polynomialToEvaluate);
            lhsMatrixGiMon(dofCounter+1:dofCounter+length(edgeDOFs), indexPolynomial) = edgeDOFs;
            dofCounter = dofCounter + length(edgeDOFs);
        end
        % We apply (7) on each face.
        for indexFace = 1:length(elemObj.faces)
            faceDOFs = sysBasesObj.evaluateFaceDOF(indexFace, polynomialToEvaluate);
            lhsMatrixGiMon(dofCounter+1:dofCounter+length(faceDOFs), indexPolynomial) = faceDOFs;
            dofCounter = dofCounter + length(faceDOFs);
        end
        % We apply (8) inside each element.
        volumeDOFs = sysBasesObj.evaluateVolumeDOF(elemObj, polynomialToEvaluate);
        lhsMatrixGiMon(dofCounter+1:dofCounter+length(volumeDOFs), indexPolynomial) = volumeDOFs;
    end

    % We obtain the coefficients as the dual basis of the dofs.
    coefficients = lhsMatrixGiMon\eye(lengthBases);
    sysBasesObj.referenceCoefficients = coefficients;
end