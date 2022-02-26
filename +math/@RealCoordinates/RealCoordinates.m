classdef RealCoordinates < handle
    % This class is used to store the symbolic representation of x, y, and z.

    properties
        % Symbolic array with different size depending on the geometry of the object.
        coordinates sym
    end

    methods
        function realCoordinatesObject = RealCoordinates(loadSymVariables)
            % Constructor which defines the array of symbolic variables x,y,z
            % used in the code, and if they exist, they load them (it is a little
            % slow for MATLAB).

            if (nargin > 0)
                loadedSym = false;
                if (loadSymVariables)
                    realName = 'realCoordinates';
                    fullFile = strcat('+math/@RealCoordinates/precomputedReal/',realName,'.mat');
                    if (isfile(fullFile))
                        load(fullFile,'tempReal');
                        realCoordinatesObject.coordinates = tempReal.coordinates;
                        loadedSym = true;
                    end
                end

                if (~loadedSym)

                    saveFunctions = true;

                    syms x y z
                    assume(x, 'real');
                    assume(y, 'real');
                    assume(z, 'real');
                    realCoordinatesObject.coordinates = [x y z];

                    if (saveFunctions)
                        realCoordinatesObject.saveRealCoordinates();
                    end
                end
            end
        end

        function saveRealCoordinates (realCoordinatesObject)
            % Function used to store the symbolic variables used in RealCoordinates.

            realName = 'realCoordinates';
            tempReal = 'tempReal';
            functionsStruct.(tempReal) = realCoordinatesObject;
            fullFile = fullfile('+math/@RealCoordinates/precomputedReal/',realName);
            if (~exist('+math/@RealCoordinates/precomputedReal/', 'dir'))
                mkdir ('+math/@RealCoordinates/precomputedReal/');
            end
            save (fullFile, '-struct', 'functionsStruct');
        end
    end

end