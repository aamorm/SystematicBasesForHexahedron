function [weights, points] = getGaussPointsForQuadrilateral(order)
    % GETGAUSSPOINTFORQUADRILATERAL gives the weights and 2D points to perform
    % numerical integration on one quadrilateral face.
    % GETGAUSSPOINTFORQUADRILATERAL(order) returns the points that we need to do
    % a numerical integration for a function up to the order passed as
    % parameter. These points are obtained as the tensor product of the
    % 1D gauss points for the segment.
    % See also GETGAUSSPOINTFORSEGMENT

    % We get the corresponding points for one segment.
    [weightsSegment, pointsSegment] = math.getGaussPointsForSegment(order);

    num1DGauss = length(weightsSegment);

    weights = zeros(num1DGauss^2,1);
    points = zeros(num1DGauss^2,2);

    % We implement here the tensor product of the 1D points.
    for indexPoints = 1:num1DGauss
        weights((indexPoints-1)*num1DGauss+1:indexPoints*num1DGauss) = weightsSegment(indexPoints)*weightsSegment(1:num1DGauss);
        points((indexPoints-1)*num1DGauss+1:indexPoints*num1DGauss,1) = pointsSegment(1:num1DGauss);
        points((indexPoints-1)*num1DGauss+1:indexPoints*num1DGauss,2) = pointsSegment(indexPoints);
    end
end