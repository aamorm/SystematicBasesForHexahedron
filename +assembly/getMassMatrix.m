function massMatrix = getMassMatrix(refBasesObj, elemObj, jacobianMatrix, materialPropertyObj)
    % GETMASSMATRIX - returns the mass matrix implemented with numerical
    % integration.
    % GETMASSMATRIX(refBasesObj, elemObj, jacobianMatrix, materialPropertyObj)
    % takes the basis functions to use (defined in the reference element), the
    % element where we perform the numerical integration for the mass matrix,
    % the jacobian matrix to map the basis function to the real element,
    % and the material to get the inverse of the magnetic permeability.

    % We get the gauss points to perform the numerical integration.
    integrationOrder = 2*elemObj.pOrder;
    [gaussWeights,gaussPoints] = math.getGaussPoints(integrationOrder);

    % Initialization.
    massMatrix = zeros(54);

    % This is assumed to be constant within the element (here we don't use
    % curved or inhomogeneous materials).
    epsilonR = materialPropertyObj.evaluateProperty();
    detJacob = det(jacobianMatrix);

    % We need to run through all the points for the numerical integration.
    for gaussIndex = 1:length(gaussWeights)

        % We evaluate the curl of the polynomials in the reference element, and
        % then map it to the real element.
        allBasesEvaluated = refBasesObj.getBasesEvaluated(gaussPoints(gaussIndex,:));
        allBasesReal = jacobianMatrix\allBasesEvaluated.';

        % We accumulate to perform the numerical integration.
        massMatrix = massMatrix + gaussWeights(gaussIndex)*allBasesReal.'*epsilonR*(allBasesReal)*abs(detJacob);

    end