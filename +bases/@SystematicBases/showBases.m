function showBases(sysBasesObj, basesToShow)
    % SHOWBASES displays the coefficients that multiply the polynomials
    % contained in the spaace.
    % SHOWBASES(sysBasesObj, basesToShow) uses the coefficients obtained
    % from GETCOEFFICIENTS to display for the different bases the
    % coefficients known as a1, a2... in (4). If basesToShow is omitted,
    % all the functions are displayed.

    if (nargin == 1)
        basesToShow = 1:54;
    end

    tolerance = 1e-12;

    lengthBases = length(basesToShow);

    stringCoefficients = '';
    header = 'Ni  ';
    header2 = '----';
    for indexBases = 1:lengthBases
        stringCoefficients = strcat(stringCoefficients,'|%4g');
        header = [header,'|%4i'];
        header2 = [header2,'|----'];
    end
    stringCoefficients = strcat(stringCoefficients,'\n');
    header = [header,'\n'];
    header2 = [header2,'\n'];

    nameCoefficients = {};
    nameCoefficients{1}= 'a1\t';
    nameCoefficients{2}= 'a2\t';
    nameCoefficients{3}= 'a3\t';
    nameCoefficients{4}= 'a4\t';
    nameCoefficients{5}= 'a5\t';
    nameCoefficients{6}= 'a6\t';
    nameCoefficients{7}= 'a7\t';
    nameCoefficients{8}= 'a8\t';
    nameCoefficients{9}= 'a9\t';
    nameCoefficients{10} = 'a10\t';
    nameCoefficients{11} = 'a11\t';
    nameCoefficients{12} = 'a12\t';
    nameCoefficients{13} = 'a13\t';
    nameCoefficients{14} = 'a14\t';
    nameCoefficients{15} = 'a15\t';
    nameCoefficients{16} = 'a16\t';
    nameCoefficients{17} = 'a17\t';
    nameCoefficients{18} = 'a18\t';
    nameCoefficients{19} = 'b1\t';
    nameCoefficients{20} = 'b2\t';
    nameCoefficients{21} = 'b3\t';
    nameCoefficients{22} = 'b4\t';
    nameCoefficients{23} = 'b5\t';
    nameCoefficients{24} = 'b6\t';
    nameCoefficients{25} = 'b7\t';
    nameCoefficients{26} = 'b8\t';
    nameCoefficients{27} = 'b9\t';
    nameCoefficients{28} = 'b10\t';
    nameCoefficients{29} = 'b11\t';
    nameCoefficients{30} = 'b12\t';
    nameCoefficients{31} = 'b13\t';
    nameCoefficients{32} = 'b14\t';
    nameCoefficients{33} = 'b15\t';
    nameCoefficients{34} = 'b16\t';
    nameCoefficients{35} = 'b17\t';
    nameCoefficients{36} = 'b18\t';
    nameCoefficients{37} = 'c1\t';
    nameCoefficients{38} = 'c2\t';
    nameCoefficients{39} = 'c3\t';
    nameCoefficients{40} = 'c4\t';
    nameCoefficients{41} = 'c5\t';
    nameCoefficients{42} = 'c6\t';
    nameCoefficients{43} = 'c7\t';
    nameCoefficients{44} = 'c8\t';
    nameCoefficients{45} = 'c9\t';
    nameCoefficients{46} = 'c10\t';
    nameCoefficients{47} = 'c11\t';
    nameCoefficients{48} = 'c12\t';
    nameCoefficients{49} = 'c13\t';
    nameCoefficients{50} = 'c14\t';
    nameCoefficients{51} = 'c15\t';
    nameCoefficients{52} = 'c16\t';
    nameCoefficients{53} = 'c17\t';
    nameCoefficients{54} = 'c18\t';

    fprintf(header,basesToShow);
    fprintf(header2,basesToShow);
    coefficients = sysBasesObj.referenceCoefficients;
    % To remove numerical noise.
    coefficients(abs(coefficients)<tolerance) = 0;

    for indexBases = 1:54
        lineToShow = strcat(nameCoefficients{indexBases},stringCoefficients);
        stringToShow = sprintf(lineToShow, coefficients(indexBases, basesToShow));
        fprintf('%s',strrep(stringToShow,'-0',' 0'))
    end
    fprintf(header2,basesToShow);

end