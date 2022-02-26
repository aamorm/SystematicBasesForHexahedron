function allBasesEvaluated = getBasesEvaluated(sysBasesObj, gaussPoint)
    % GETBASESEVALUATED returns the curl of the 54 basis functions.
    % GETBASESEVALUATED(sysBasesObj, gaussPoint) takes the linear combination of the
    % curl of the polynomials stored in sysBasesObj and evaluate them in gaussPoint. Then,
    % the linear combination with the coefficients obtained in GETCOEFFICIENTS is obtained.
    % See also: GETCOEFFICIENTS

    coefficients = sysBasesObj.referenceCoefficients;
    lengthBases = size(sysBasesObj.polyAllFunctions,1);
    allBasesEvaluated = zeros(size(sysBasesObj.polyAllFunctions));
    polynomialsEvaluated = zeros(size(sysBasesObj.polyAllFunctions));

    % We obtain the evaluation of the polynomial in the point passed as parameter.
    for indexPolymials = 1:lengthBases
        for indexCoordinates = 1:3
            polynomialsEvaluated(indexPolymials, indexCoordinates) = sysBasesObj.polyAllFunctions(indexPolymials, indexCoordinates).evaluatePolynomial(gaussPoint);
        end
    end

    % We apply the linear combination of the polynomials to obtain the 54 bases.
    for indexBases = 1:lengthBases
        allBasesEvaluated(indexBases,:) = coefficients(:,indexBases).'*polynomialsEvaluated;
    end

end