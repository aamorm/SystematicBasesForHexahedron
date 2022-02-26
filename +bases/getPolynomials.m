function symPolynomials = getPolynomials(order)
    % GETPOLYNOMIALS Gives the symbolic representation of the polynomials that
    % compose the mixed-order curl-conforming hexahedral space.
    %
    % GETPOLYNOMIALS(order) - Returns the polynomials for
    % the space of Nedelec of order <order> (up to order 4) for the hexahedron.

    xyzObj = math.RealCoordinates(true);
    xyz = xyzObj.coordinates;
    x = xyz(1); y = xyz(2); z = xyz(3);

    % We obtain the space as the tensor product of the mixed poly spaces.
    sizeBases = 3*order*(order+1)^2;
    symPolynomials = sym(zeros(sizeBases,3));
    symPolynomials(1:order*(order+1)^2,1) = math.getMixedPolySpace([x y z], order-1, order, order);
    symPolynomials(order*(order+1)^2+1:2*order*(order+1)^2,2) = math.getMixedPolySpace([x y z], order, order-1, order);
    symPolynomials(2*order*(order+1)^2+1:end,3) = math.getMixedPolySpace([x y z], order, order, order-1);