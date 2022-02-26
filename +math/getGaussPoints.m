function [weights,points] = getGaussPoints(order)
    % GETGAUSSPOINT gives the weights and 3D points to perform
    % numerical integration on one hexahedron.
    % GETGAUSSPOINT(order) returns the points that we need to do
    % a numerical integration for a function up to the order passed as
    % parameter. These points are obtained as the tensor product of the
    % 1D gauss points for the segment and the 2D points for the quadrilateral.
    % See also GETGAUSSPOINTFORSEGMENT, GETGAUSSPOINTSFORQUADRILATERAL


    [weightsSegment, pointsSegment] = math.getGaussPointsForSegment(order);
    [weights2D, points2D] = math.getGaussPointsForQuadrilateral(order);

    num1DGauss = length(weightsSegment);
    num2DGauss = length(weights2D);

    weights = zeros(num1DGauss*num2DGauss,1);
    points = zeros(num1DGauss*num2DGauss,3);

    for index_points = 1:num1DGauss
        weights((index_points-1)*num2DGauss+1:index_points*num2DGauss) = weightsSegment(index_points)*weights2D(1:num2DGauss);
        points((index_points-1)*num2DGauss+1:index_points*num2DGauss,1:2) = points2D(1:num2DGauss,:);
        points((index_points-1)*num2DGauss+1:index_points*num2DGauss,3) = pointsSegment(index_points);
    end

end



