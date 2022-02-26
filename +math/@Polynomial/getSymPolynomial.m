function symPoly = getSymPolynomial(polyObj)
    % GETSYMPOLYNOMIAL returns a symbolic representation of the polynomial
    % object.
    % GETSYMPOLYNOMIAL(polyObj) use symbolic real coordinates to return the
    % symbolic representation of the polynomial (useful for debugging purposes).
    % The polynomial object may be an array.

    % Initialization.
    symPoly = sym(zeros(size(polyObj)));

    % Run through all the polynomial objects passed as parameter.
    for indexPolyRow = 1:size(polyObj,1)
        for indexPolyCol = 1:size(polyObj,2)
            realObj = math.RealCoordinates();
            realCoords = realObj.coordinates;

            coefficients = polyObj(indexPolyRow,indexPolyCol).coefficients;

            % Run through all the coefficients.
            for t1Index = 1:size(coefficients,1)
                for t2Index = 1:size(coefficients,2)
                    for t3Index = 1:size(coefficients,3)
                        symPoly(indexPolyRow, indexPolyCol) = symPoly(indexPolyRow, indexPolyCol) + coefficients(t1Index,t2Index,t3Index)*...
                            realCoords(1)^(t1Index-1)*realCoords(2)^(t2Index-1)*realCoords(3)^(t3Index-1);
                    end
                end
            end
        end
    end