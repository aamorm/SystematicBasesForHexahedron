function faceDOFs = evaluateFaceDOF(sysBasesObj, faceNumber, functionToEvaluate)
    % EVALUATEFACEDOF returns the numerical integration of (7).
    % EVALUATEFACEDOF(sysBasesOb,faceNumber,functionToEvaluate) applys
    % (7) on the face of the element passed as parameter to the polynomial
    % representation given in functionToEvaluate. This function returns the four
    % dofs for the q polynomial vectors defined in the SystematicBasis object.

    % All the faces in the reference element have unit size.
    detJacob2D = 1;

    % We obtain the gauss points to perform the numerical integration on a
    % quadrilateral domain.
    [gaussWeights, gaussPoints2D] = math.getGaussPointsForQuadrilateral(2*sysBasesObj.pOrder);

    qArray = squeeze(sysBasesObj.qRefRectangular(faceNumber,:,:));
    faceDOFs = zeros(size(qArray,1),1);
    functionEvaluated = zeros(1,3);
    qRefEvaluated = zeros(3,1);

    % We apply the functional for all the q polynomial vectors.
    for indexQ = 1:size(qArray,1)
        for indexPoint = 1:length(gaussWeights)
            % To get the 3D representation of the gauss point for the segment.
            gaussPoint3D = math.transform2Dto3DInReferenceElement(gaussPoints2D(indexPoint,:), faceNumber);

            % We evaluate the different polynomials.
            for indexCoordinates = 1:3
                functionEvaluated(indexCoordinates) = functionToEvaluate(indexCoordinates).evaluatePolynomial(gaussPoint3D);
                qRefEvaluated(indexCoordinates) = qArray(indexQ,indexCoordinates).evaluatePolynomial(gaussPoint3D);
            end
            % We perform here the numerical integration.
            faceDOFs(indexQ) = faceDOFs(indexQ) + gaussWeights(indexPoint)*dot(functionEvaluated,qRefEvaluated)*detJacob2D;
        end
    end

end
