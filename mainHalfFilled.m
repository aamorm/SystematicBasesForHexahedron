%% Convergence for a half-filled cavity.
% This script is used as a demonstration of the capabilities of the basis functions
% in the submission.
% Results from fig. 5 for the half-filled cavity are obtained running this script.

%% Definition of parameters.
% Parameters for the half-filled cavity as defined in https://doi.org/10.1002/mmce.22342
a = 0.01;
b = 0.001;
c = 0.01;
h = 0.005;
epr = 2;
sigmaCond = 0;

%% Obtention of analytic eigenvalues.
% Eigenvalues for the first six modes.
k101 = math.getKcFromHalfFilledCavity(a, b, c, h, epr, sigmaCond, 1, 0, 300, 16);
k102 = math.getKcFromHalfFilledCavity(a, b, c, h, epr, sigmaCond, 1, 0, 600, 16);
k103 = math.getKcFromHalfFilledCavity(a, b, c, h, epr, sigmaCond, 1, 0, 800, 16);
k201 = math.getKcFromHalfFilledCavity(a, b, c, h, epr, sigmaCond, 2, 0, 540, 16);
k202 = math.getKcFromHalfFilledCavity(a, b, c, h, epr, sigmaCond, 2, 0, 760, 16);
k301 = math.getKcFromHalfFilledCavity(a, b, c, h, epr, sigmaCond, 3, 0, 750, 16);
numberKc = 6;
kc = [k101 k201 k102 k301 k202 k103];

%% Loading of the hexahedral meshes.
% In this container are included the meshes used for the results.
load('+settings/meshesHalfFilledTAP2021.mat','projectMeshes');
lengthMeshes = length(projectMeshes);
% Container to store the error for the different eigenvalues.
errorHalfConvergence = zeros(numberKc,lengthMeshes);
% Container for the average size of the elements (x-axis in fig. 5).
lengthHalfConvergence = zeros(3,lengthMeshes);

%% Obtention of the basis functions.
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

%% Running through all the meshes.
for indexMesh = 1:length(projectMeshes)

    meshObj = projectMeshes(indexMesh);

    % We generate the dofs inside the mesh.
    numDOF = meshObj.generateDOF();
    disp(['Numbering of DOF finished: ', num2str(numDOF), ' unknowns.'])

    % We obtain the global stiffness and mass matrices.
    FEMatrices = assembly.getGlobalMatrices(meshObj);
    globalStiff = FEMatrices.stiffness; globalMass = FEMatrices.mass;

    % We provide an initial guesh for the sparse eigensolver.
    sigmaEstimation = double(kc(1)^2+1.5*(kc(end)-kc(1))^2);
    eigsNum = sort(eigs(globalStiff, globalMass, numberKc, sigmaEstimation));

    % We compute the error for the generalized eigenvalue problem.
    errorHalfConvergence (:, indexMesh) = abs((kc.^2)'-eigsNum)./abs((kc.^2)');
    disp(['Mean error obtained: ', num2str(mean(errorHalfConvergence (:, indexMesh)),16)])

    % We get here some statistics from the mesh to plot the results.
    [lengthHalfConvergence(1,indexMesh), lengthHalfConvergence(2,indexMesh), lengthHalfConvergence(3,indexMesh)] = meshObj.getLengthStatistics();
end

%% Plotting the results.
math.plotHalfFilledCavity(errorHalfConvergence,lengthHalfConvergence);
