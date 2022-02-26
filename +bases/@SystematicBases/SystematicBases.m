classdef SystematicBases < handle

    % Class that contains the mixed-order curl-conforming basis functions
    % presented in the paper.

    properties

        % Reference elements where the functions belong.
        refElement geometry.Element

        % Order of the basis functions (only p=2 supported).
        pOrder double

        % Array of all the polynomials that compose the mixed-order.
        % space of functions.
        polyAllFunctions(:,3) math.Polynomial

        % Array of the curl of polynomials in polyAllFunctions.
        polyAllCurlFunctions(:,3) math.Polynomial

        % Symbolic representation of the polynomials.
        symAllFunctions(:,3) sym

        % Symbolic representation of the curl of the polynomials.
        symAllCurlFunctions(:,3) sym

        % Array of symbolic coordinates.
        realCoordinates math.RealCoordinates

        % Reference q polynomials for the edge dof (6).
        qRefEdge math.Polynomial
        % Reference q polynomials for the face dof (7).
        qRefRectangular (:,:,3) math.Polynomial
        % Reference q polynomials for the volume dof (8).
        qRefHexa (:,3) math.Polynomial

        % Reference coefficients obtained when executing getCoefficients().
        referenceCoefficients(:,:) double

    end

    methods
        function systematicBasesObject = SystematicBases()
            % Constructor of the basis functions. This method gets the
            % saved object from precomputedBases, or initializes all the
            % machinery to obtain the coefficients solving the dual bases.

            basesName = 'systematicBasesHexa2';
            % Get the precomputed bases from memory.
            if (isfile(strcat('+bases/precomputedBases/',basesName,'.mat')))
                load(strcat('+bases/precomputedBases/',basesName,'.mat'), 'tempBases')

                systematicBasesObject.refElement = tempBases.refElement;
                systematicBasesObject.pOrder = tempBases.pOrder;
                systematicBasesObject.polyAllFunctions = tempBases.polyAllFunctions;
                systematicBasesObject.polyAllCurlFunctions = tempBases.polyAllCurlFunctions;
                systematicBasesObject.symAllFunctions = tempBases.symAllFunctions;
                systematicBasesObject.symAllCurlFunctions = tempBases.symAllCurlFunctions;
                systematicBasesObject.realCoordinates = tempBases.realCoordinates;
                systematicBasesObject.qRefEdge = tempBases.qRefEdge;
                systematicBasesObject.qRefRectangular = tempBases.qRefRectangular;
                systematicBasesObject.qRefHexa = tempBases.qRefHexa;
                systematicBasesObject.referenceCoefficients = tempBases.referenceCoefficients;
            else
                % We obtain the reference element defined in Fig. 1.
                systematicBasesObject.refElement = geometry.Element ('referenceElement');
                % We define the order, which is important for assigning the dofs.
                systematicBasesObject.pOrder = 2;
                % We obtain symbolic variables [x, y, z].
                systematicBasesObject.realCoordinates = math.RealCoordinates(true);
                xyz = systematicBasesObject.realCoordinates.coordinates;

                % These are the symbolic representation of the polynomials that
                % compose the space of functions.
                symAllFunctions = bases.getPolynomials(systematicBasesObject.pOrder);
                lengthPolymials = size(symAllFunctions,1);

                % We obtain the curl of all these polynomials.
                symAllCurlFunctions = sym(zeros(size(symAllFunctions)));
                for indexPolymial = 1:lengthPolymials
                    symAllCurlFunctions(indexPolymial,:) = curl(symAllFunctions(indexPolymial,:), xyz).';
                end
                systematicBasesObject.symAllFunctions = symAllFunctions;
                systematicBasesObject.symAllCurlFunctions = symAllCurlFunctions;

                % Now, we get the polynomial representation of these polynomial.s
                systematicBasesObject.polyAllFunctions(lengthPolymials, 3) = math.Polynomial;
                systematicBasesObject.polyAllCurlFunctions(lengthPolymials, 3) = math.Polynomial;
                for indexPolymial = 1:lengthPolymials
                    for indexDimension = 1:3
                        systematicBasesObject.polyAllFunctions(indexPolymial, indexDimension) = math.Polynomial(systematicBasesObject.pOrder*ones(1,3), symAllFunctions(indexPolymial, indexDimension));
                        systematicBasesObject.polyAllCurlFunctions(indexPolymial, indexDimension) = math.Polynomial(systematicBasesObject.pOrder*ones(1,3), symAllCurlFunctions(indexPolymial, indexDimension));
                    end
                end

                % To save space in the following.
                t1 = systematicBasesObject.realCoordinates.coordinates(1);
                t2 = systematicBasesObject.realCoordinates.coordinates(2);
                t3 = systematicBasesObject.realCoordinates.coordinates(3);

                % We define the same q for all the edges to discretize (6).
                % All these q are contained in Table I.
                qRefEdge(2) = math.Polynomial();
                qRefEdge(1) = math.Polynomial(systematicBasesObject.pOrder*ones(1,3), 1-t1);
                qRefEdge(2) = math.Polynomial(systematicBasesObject.pOrder*ones(1,3), t1);

                % The vector polynomials in (7) are defined here for all the
                % faces following the order in the reference element given in
                % getFaceByLocalEdges.
                qSymRectangular = sym(zeros(6,4,3));
                qSymRectangular(1,1,:) = [1-t1 0 0];
                qSymRectangular(1,2,:) = [t1 0 0];
                qSymRectangular(1,3,:) = [0 1-t2 0];
                qSymRectangular(1,4,:) = [0 t2 0];
                qSymRectangular(2,1,:) = [1-t1 0 0];
                qSymRectangular(2,2,:) = [t1 0 0];
                qSymRectangular(2,3,:) = [0 1-t2 0];
                qSymRectangular(2,4,:) = [0 t2 0];
                qSymRectangular(3,1,:) = [1-t1 0 0];
                qSymRectangular(3,2,:) = [t1 0 0];
                qSymRectangular(3,3,:) = [0 0 1-t3];
                qSymRectangular(3,4,:) = [0 0 t3];
                qSymRectangular(4,1,:) = [0 1-t2 0];
                qSymRectangular(4,2,:) = [0 t2 0];
                qSymRectangular(4,3,:) = [0 0 1-t3];
                qSymRectangular(4,4,:) = [0 0 t3];
                qSymRectangular(5,1,:) = [1-t1 0 0];
                qSymRectangular(5,2,:) = [t1 0 0];
                qSymRectangular(5,3,:) = [0 0 1-t3];
                qSymRectangular(5,4,:) = [0 0 t3];
                qSymRectangular(6,1,:) = [0 1-t2 0];
                qSymRectangular(6,2,:) = [0 t2 0];
                qSymRectangular(6,3,:) = [0 0 1-t3];
                qSymRectangular(6,4,:) = [0 0 t3];

                % We obtain now the polynomial representation.
                qRefRectangular(6,4,3) = math.Polynomial();
                for indexFace = 1:6
                    for indexComponent = 1:3
                        for indexQ = 1:4
                            qRefRectangular(indexFace,indexQ, indexComponent) = math.Polynomial(systematicBasesObject.pOrder*ones(1,3), qSymRectangular(indexFace, indexQ, indexComponent));
                        end
                    end
                end

                % Finally, we define the vector polynomial q needed in (8)
                qSymHexa = sym(zeros(6,3));
                qSymHexa(1,:) = [1-t1 0 0];
                qSymHexa(2,:) = [t1 0 0];
                qSymHexa(3,:) = [0 1-t2 0];
                qSymHexa(4,:) = [0 t2 0];
                qSymHexa(5,:) = [0 0 1-t3];
                qSymHexa(6,:) = [0 0 t3];

                % Obtaining now the polynomial representation.
                qRefHexa(6,3) = math.Polynomial();
                for indexComponent = 1:3
                    for indexQ = 1:6
                        qRefHexa(indexQ, indexComponent) = math.Polynomial(systematicBasesObject.pOrder*ones(1,3), qSymHexa(indexQ, indexComponent));
                    end
                end

                systematicBasesObject.qRefEdge = qRefEdge;
                systematicBasesObject.qRefRectangular = qRefRectangular;
                systematicBasesObject.qRefHexa = qRefHexa;
            end

        end
    end

    methods (Static)
        function removeBases()
            % This method removes the copy stored in memory to generate a new
            % set of basis functions.

            if (isfile('+bases/precomputedBases/systematicBasesHexa2.mat'))
                delete '+bases/precomputedBases/systematicBasesHexa2.mat'
            end

        end

    end

end