function stiffMatrix = getStiffMatrix(refBasesObj, elemObj, jacobianMatrix, materialPropertyObj)
    % GETSTIFFMATRIX - returns the stiffness matrix implemented with numerical
    % integration.
    % GETSTIFFMATRIX(refBasesObj, elemObj, jacobianMatrix, materialPropertyObj)
    % takes the basis functions to use (defined in the reference element), the
    % element where we perform the numerical integration for the stiffness matrix,
    % the jacobian matrix to map the basis function to the real element,
    % and the material to get the inverse of the magnetic permeability.

    % We get the gauss points to perform the numerical integration.
    integrationOrder = 2*elemObj.pOrder;
    [gaussWeights,gaussPoints] = math.getGaussPoints(integrationOrder);

    % Initialization.
    stiffMatrix = zeros(54);

    % This is assumed to be constant within the element (here we don't use
    % curved or inhomogeneous materials).
    invMuRelative = materialPropertyObj.evaluateProperty();
    detJacob = det(jacobianMatrix);

    % We need to run through all the points for the numerical integration.
    for gaussIndex = 1:length(gaussWeights)

        % We evaluate the curl of the polynomials in the reference element, and
        % then map it to the real element.
        allCurlBasesEvaluated = refBasesObj.getCurlBasesEvaluated(gaussPoints(gaussIndex,:));
        allCurlBasesReal = allCurlBasesEvaluated*jacobianMatrix/detJacob;

        % We accumulate to perform the numerical integration.
        stiffMatrix = stiffMatrix + gaussWeights(gaussIndex)*allCurlBasesReal*invMuRelative*(allCurlBasesReal.')*abs(detJacob);
    end