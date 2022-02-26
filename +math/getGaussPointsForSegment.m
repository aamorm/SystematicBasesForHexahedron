function [weights, points] = getGaussPointsForSegment(order)
    % GETGAUSSPOINTFORSEGMENT gives the weights and 1D points to perform
    % numerical integration at one segment.
    % GETGAUSSPOINTFORSEGMENT(order) returns the points that
    % we need to do a numerical integration for a function
    % up to the order passed as parameter.

    % In terms of the order we return a different number of points.
    switch order

    case num2cell([0 1])
        weights = 1;
        points = 0.555555555555555;

    case num2cell([2 3])
        weights(1:2) = 1/2;
        points(1) = 0.788675134594813;
        points(2) = 0.211324865405187;

    case num2cell([4 5])
        weights = [ 0.277777777777778
                    0.444444444444444
                    0.277777777777778];

        points = [  0.112701665379259
                    0.500000000000000
                    0.887298334620741];
    otherwise
        error("Order not coded")
    end

end