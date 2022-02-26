function allCurlBasesEvaluated = getCurlBasesEvaluated(sysBasesObj, gaussPoint)
    % GETCURLBASESEVALUATED returns the curl of the 54 basis functions.
    % GETCURLBASESEVALUATED(sysBasesObj, gaussPoint) takes the linear combination of the
    % curl of the polynomials stored in sysBasesObj and evaluate them in gaussPoint. Then,
    % the linear combination with the coefficients obtained in GETCOEFFICIENTS is obtained.
    % See also: GETCOEFFICIENTS

    coefficients = sysBasesObj.referenceCoefficients;
    lengthBases = size(sysBasesObj.polyAllFunctions,1);
    allCurlBasesEvaluated = zeros(size(sysBasesObj.polyAllCurlFunctions));
    curlPolynomialsEvaluated = zeros(size(sysBasesObj.polyAllCurlFunctions));

    % We obtain the curl of the polynomial in the point passed as parameter.
    for indexPolymials = 1:lengthBases
        for indexCoordinates = 1:3
            curlPolynomialsEvaluated(indexPolymials, indexCoordinates) = sysBasesObj.polyAllCurlFunctions(indexPolymials, indexCoordinates).evaluatePolynomial(gaussPoint);
        end
    end

    % We apply the linear combination of the polynomials to obtain the 54 bases.
    for indexBases = 1:lengthBases
        allCurlBasesEvaluated(indexBases,:) = coefficients(:,indexBases).'*curlPolynomialsEvaluated;
    end

end