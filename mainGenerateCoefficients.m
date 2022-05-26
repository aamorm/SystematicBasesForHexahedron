%% Driver for the generation of basis functions following the pseudcode shown in the document.

%% Obtention of the basis functions following the figure 2.
% For demonstration purposes.
disp("Removing the bases stored...")
bases.SystematicBases.removeBases();
% The bases are defined as an object, and here we define the polynomial q in the
% dofs (6), (7), and (8).
sysBasesObj = bases.SystematicBases();
disp("Generating the new coefficients...")
% We obtain the coefficients as the dual basis to the Nédélec dofs.
sysBasesObj.getCoefficients();
% We store the coefficients for using them later.
disp("Storing the coefficients generated...")
sysBasesObj.saveCoefficients();
disp("Showing the coefficients of the polynomials...")
bases.showPolynomials();
sysBasesObj.showBases();