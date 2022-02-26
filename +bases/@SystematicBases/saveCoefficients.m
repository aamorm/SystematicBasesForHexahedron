function saveCoefficients(systematicBasesObject)
    % SAVECOEFFICIENTS store the whole object of systematic bases.
    % SAVECOEFFICIENTS(systematicBasesObject) takes the object
    % passed as parameter (including the coefficients obtained
    % as dual bases) and store it to be faster in following calls.

    basesName = 'systematicBasesHexa2';
    tempBases = 'tempBases';
    functionsStruct.(tempBases) = systematicBasesObject;
    fullFile = fullfile('+bases/precomputedBases/',basesName);
    if (~exist('+bases/precomputedBases/', 'dir'))
        mkdir ('+bases/precomputedBases/');
    end
    save (fullFile, '-struct', 'functionsStruct');

end