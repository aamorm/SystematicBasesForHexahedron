function evalPoly = evaluatePolynomial(polyObj, r)
    % EVALUATEPOLYNOMIAL gives the evaluation of the polynomial
    % object in a point r.
    % EVALUATEPOLYNOMIAL(polyObj, r) runs through all the coefficients in the
    % polynomial and use the vector coordinate r to return the value of the polynomial.

    % To speed up computations.
    tolerance = 1e-16;

    evalPoly = 0;
    coefficients = polyObj.coefficients;

    lengthT1 = size(coefficients,1);
    lengthT2 = size(coefficients,2);
    lengthT3 = size(coefficients,3);
    for t1Index = 1:lengthT1
        for t2Index = 1:lengthT2
            for t3Index = 1:lengthT3
                if (abs(coefficients(t1Index,t2Index,t3Index))>tolerance)
                    evalPoly = evalPoly + coefficients(t1Index,t2Index,t3Index)*...
                        r(1)^(t1Index-1)*r(2)^(t2Index-1)*r(3)^(t3Index-1);
                end
            end
        end
    end

    end