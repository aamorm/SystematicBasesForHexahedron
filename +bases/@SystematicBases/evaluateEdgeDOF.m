function edgeDOFs = evaluateEdgeDOF(sysBasesObj, edgeObj, functionToEvaluate)
    % EVALUATEEDGEDOF returns the numerical integration of (6).
    % EVALUATEEDGEDOF(sysBasesObj,edgeObj,functionToEvaluate) applys (6) at the
    % edge of the element passed as parameter to the polynomial representation
    % given in functionToEvaluate. This function returns the two dofs for the q
    % polynomials defined in the SystematicBasis object.

    edgeUnitVector = edgeObj.getUnitVector();
    % We obtain the 1D jacobian for the edge.
    [jacobianEdge, originPointInEdge] = edgeObj.getJacobian();
    % We need the length of the edge to evaluate the dof
    lengthEdge = sqrt(det(jacobianEdge.'*jacobianEdge));

    % We obtain the points for the numerical integration.
    [gaussWeights, gaussPoints1D] = math.getGaussPointsForSegment(2*sysBasesObj.pOrder);
    qArray = sysBasesObj.qRefEdge;
    edgeDOFs = zeros(size(qArray));

    % We apply the functional for all the q polynomials.
    for indexQ = 1:length(qArray)
        for indexPoint = 1:length(gaussWeights)
            % To get the 3D representation of the gauss point for the segment.
            point3D = jacobianEdge*gaussPoints1D(indexPoint)+originPointInEdge;
            functionEvaluated = zeros(1,3);
            % We evaluate the different polynomials.
            for indexCoordinates = 1:3
                functionEvaluated(indexCoordinates) = functionToEvaluate(indexCoordinates).evaluatePolynomial(point3D);
            end
            qEvaluated = qArray(indexQ).evaluatePolynomial([gaussPoints1D(indexPoint) 0 0]);
            % We perform here the numerical integration.
            edgeDOFs(indexQ) = edgeDOFs(indexQ) + gaussWeights(indexPoint)*dot(functionEvaluated,edgeUnitVector)*qEvaluated*lengthEdge;
        end
    end

end

