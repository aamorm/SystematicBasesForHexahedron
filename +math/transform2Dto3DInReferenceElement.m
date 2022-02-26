function points3D = transform2Dto3DInReferenceElement(points2D, faceNumber)
    % TRANSFORM2DTO3DINREFERENCEELEMENT - Transforms 2D points defined on some
    % face of the hexahedron into its 3D representation.
    %
    % TRANSFORM2DTO3DINREFERENCEELEMENT(points2D, faceNumber) takes the 2D representation
    % of the point and returns the corresponding 3D representation for a given face
    % specified by faceNumber. The same numbering as in GETFACEBYLOCALEDGES is used.


    switch faceNumber
    case 1
        points3D = [points2D(1) points2D(2) 0];
    case 2
        points3D = [points2D(1) points2D(2) 1];
    case 3
        points3D = [points2D(1) 0 points2D(2)];
    case 4
        points3D = [1 points2D(1) points2D(2)];
    case 5
        points3D = [points2D(1) 1 points2D(2)];
    case 6
        points3D = [0 points2D(1) points2D(2)];
    otherwise
        error('A hexahedron only has 6 faces.')
    end
