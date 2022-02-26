function showPolynomials()
    % SHOWBASES displays the order of the polynomials that we follow
    % for applying the coefficients.

    symPolynomials = bases.getPolynomials(2);

    for indexPolynomial = 1:size(symPolynomials,1)
        fprintf('Polynomial #%2i | [%9s,%9s,%9s]\n',indexPolynomial,symPolynomials(indexPolynomial,:));
    end

end