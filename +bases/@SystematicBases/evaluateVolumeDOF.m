function volDOFs = evaluateVolumeDOF(sysBasesObj, elemObj, functionToEvaluate)
    % EVALUATEVOLUMEDOF returns the numerical integration of (8).
    % EVALUATEVOLUMEDOF(sysBasesObj,elemObj,functionToEvaluate) applys
    % (8) for the interior of the element passed as parameter to the polynomial
    % representation given in functionToEvaluate. This function returns the six
    % dofs for the q polynomial vectors defined in the SystematicBasis object.

    % We obtain the volumetric jacobian for the element.
    jacobianMatrix = elemObj.computeJacobianMatrix();

    % We obtain the gauss points to perform the numerical integration on a
    % hexahedral domain.
    [gaussWeights,gaussPoints] = math.getGaussPoints(2*sysBasesObj.pOrder);

    qArray = sysBasesObj.qRefHexa;
    volDOFs = zeros(size(qArray,1),1);
    functionEvaluated = zeros(1,3);
    qEvaluated = zeros(1,3);

    % We apply the functional for all the q polynomial vectors.
    for indexQ = 1:size(qArray,1)
        for indexPoint = 1:length(gaussWeights)

            % We evaluate all the polynomials involved.
            for indexComponent = 1:3
                functionEvaluated(indexComponent) = functionToEvaluate(indexComponent).evaluatePolynomial(gaussPoints(indexPoint,:));
                % This should be used (probably) together with the unit vector
                qEvaluated(indexComponent) = qArray(indexQ,indexComponent).evaluatePolynomial(gaussPoints(indexPoint,:));
            end
            % We perform here the numerical integration.
            volDOFs(indexQ) = volDOFs(indexQ) + gaussWeights(indexPoint)*dot(functionEvaluated,qEvaluated)*det(jacobianMatrix);
        end
    end

end
