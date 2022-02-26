function polySpace = getFullPolySpace(t, order)
    % GETFULLPOLYSPACE Returns Q(order) for all the coordinates.
    % GETFULLPOLYSPACE(t, order) returns the polynomial space for each component
    % up to 3 dimensions.
    % t is a 1D symbolic variable.
    % See also GETMIXEDPOLYSPACE

    polySpace = sym(zeros(1,(order+1)));
    for pp = 0:order
        polySpace(pp+1) = t^pp;
    end
