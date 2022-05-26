%% Driver to show the operating principle of the basis functions.

% Point defined in the reference element.
pointToEvaluateInReferenceElement = [1/2, 1/2, 1/2];

%% Using the coefficients given in the paper.
% Table extracted from Table II in the manuscript.
disp('Evaluating the bases from a stored table of coefficients')
load('tableReferenceCoefficients');
% Polynomial order of the basis functions
orderBasisFunctions = 2;
% Polynomials that compose the space of function in the reference hexahedron.
[polynomialsInSpace, symXYZ] = bases.getPolynomials(orderBasisFunctions);
% The proposed functions are a linear combination of these polynomials with the
% coefficients obtained from the procedure shown in figure 3
symbolicReferenceFunctions = tableReferenceCoefficients.'*polynomialsInSpace;
symbolicReferenceFunctionEvaluated = zeros(size(symbolicReferenceFunctions));
for indexFunctions = 1:size(symbolicReferenceFunctions,1)
    for indexComponent = 1:size(symbolicReferenceFunctions,2)
        symbolicReferenceFunctionEvaluated(indexFunctions,indexComponent) = vpa(subs(symbolicReferenceFunctions(indexFunctions,indexComponent), symXYZ, pointToEvaluateInReferenceElement));
    end
end

%% This is the equivalent procedure following the workflow of this demonstrator.
disp('Evaluating the bases following the workflow of the code')
sysBasesObj = bases.SystematicBases();
polyReferenceFunctionEvaluated = sysBasesObj.getBasesEvaluated(pointToEvaluateInReferenceElement);

% We can compare both outputs to obtain that numerically both procedures yield
% the same results.
fprintf('The total error obtained is %e\n',sum(abs(symbolicReferenceFunctionEvaluated(:)-polyReferenceFunctionEvaluated(:))))
