function polySpace = getMixedPolySpace(t,order1,order2,order3)
    % GETMIXEDPOLYSPACE Returns Q(order1,order2,order3) for t.
    % GETMIXEDPOLYSPACE(t,order1,order2,order3) returns the mixed polynomial
    % space of Q(order1,order2,order3).
    % t is a 3D array of symbolic variables
    % order1 is the order of the first coordinate
    % order2 is the order of the second coordinate
    % order3 is the order of the third coordinate
    %
    % See also GETFULLPOLYSPACE

    if ((min([order1, order2, order3])<0) && (max([order1, order2, order3])>3))
        disp('This order is not supported');
        return
    end

    % We get the full poly space for all the components.
    polySpace = sym(zeros((order1+1)*(order2+1)*(order3+1),1));
    polySpace1 = math.getFullPolySpace(t(1),order1);
    polySpace2 = math.getFullPolySpace(t(2),order2);
    polySpace3 = math.getFullPolySpace(t(3),order3);


    % We obtain the full tensor product of all the spaces
    mixedProducts_t1t2 = polySpace1.'*polySpace2;
    mixedProducts = sym(zeros(size(mixedProducts_t1t2,1),size(mixedProducts_t1t2,2),length(polySpace3)));
    for ii = 1:length(polySpace3)
        mixedProducts(:,:,ii) = polySpace3(ii)*mixedProducts_t1t2;
    end

    % The order of the resulting matrix is the index. So, only products with
    % order less than the actual order requested (variable called here "order")
    % will be stored. Note that -1 has to be substracted to all the indices
    % since the order for the element (1,1) is 0.
    indexPolySpace = 1;
    for ii = 1:length(polySpace3)
        for jj = 1:length(polySpace2)
            for kk = 1:length(polySpace1)
                % We remove the higher-order terms.
                if ((ii+jj+kk-3)<=(order1+order2+order3))
                    polySpace(indexPolySpace) = mixedProducts(kk,jj,ii);
                    indexPolySpace = indexPolySpace + 1;
                end
            end
        end
    end