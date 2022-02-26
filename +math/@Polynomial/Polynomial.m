classdef Polynomial < handle

    % Class used to represent polynomials as a multivariate array
    % of coefficients to speed up the computations.
    % This coefficients may be symbolic (very slow) or double numbers.

    properties
        % Double array with different size depending on the variables involved
        % and the maximum order of the polynomial.
        coefficients
    end

    methods
        function polynomialObject = Polynomial(maxOrder, realExpression)
            % maxOrder is an array which specifies the maximum order for all the
            % polynomials involved.
            % [coordinates] and [symExpression] are optional, and when included
            % the polynomial is created with this coefficients using poly2list.
            % deBoorFlag is a flag which should be used when the polynomials are stored.
            if (nargin > 0)
                % Array of three dimensions (typically)
                if (length(maxOrder) == 1)
                    polynomialObject.coefficients = zeros(maxOrder+1,1);
                    % polynomialObject.symCoefficients = sym(zeros(maxOrder+1,1));
                else
                    polynomialObject.coefficients = zeros(maxOrder+1);
                    % polynomialObject.symCoefficients = sym(zeros(maxOrder+1));
                end

                if ((length(maxOrder) < 1) || (length(maxOrder) > 3))
                    error ('The order of the polynomial representation have to be specified for each dimension');
                end

                coordsObj = math.RealCoordinates(true);
                for ii = 1:length(coordsObj.coordinates)
                    assume(coordsObj.coordinates(ii), 'real');
                end

                if (~isequaln(simplify(realExpression),sym(0)))
                    coords = coordsObj.coordinates;

                    [coefficients, exponents] = coeffs(realExpression);
                    % Get place of coefficients.
                    for ii = 1:length(coefficients)
                        % Working from R2018a
                        polynomialObject.coefficients( ...
                            polynomialDegree(exponents(ii),coords(1))+1,...
                            polynomialDegree(exponents(ii),coords(2))+1,...
                            polynomialDegree(exponents(ii),coords(3))+1) = ...
                                double(coefficients(ii));
                    end

                end

            end
        end
    end

end