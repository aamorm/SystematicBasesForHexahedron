function kc = getKcFromHalfFilledCavity(a, b, c, h, epr, sigmaCond, m, n, axisLimits, resolution)
    % GETKCFROMHALFFILLEDCAVITY Taken from https://doi.org/10.5281/zenodo.3885581

    kc = 0;

    syms kcsquared kcsym

    % Lossy material
    if (sigmaCond > eps)
        lhsEquation = sqrt(kcsym^2-(m*pi/a)^2-(n*pi/b)^2)*cot(sqrt(kcsym^2-(m*pi/a)^2-(n*pi/b)^2)*(c-h));
        eprMod = epr - 1i*sigmaCond*4*pi*1e-7*299792458/kcsym;
        rhsEquation = -sqrt(eprMod*kcsym^2-(m*pi/a)^2-(n*pi/b)^2)*cot(sqrt(eprMod*kcsym^2-(m*pi/a)^2-(n*pi/b)^2)*h);
    else
        lhsEquation = sqrt(kcsquared-(m*pi/a)^2-(n*pi/b)^2)*cot(sqrt(kcsquared-(m*pi/a)^2-(n*pi/b)^2)*(c-h));
        eprMod = epr;
        rhsEquation = -sqrt(eprMod*kcsquared-(m*pi/a)^2-(n*pi/b)^2)*cot(sqrt(eprMod*kcsquared-(m*pi/a)^2-(n*pi/b)^2)*h);
    end

    if (nargin > 9)

        digitsOld = digits(resolution);
        equation = lhsEquation-rhsEquation == 0;
        if (sigmaCond > eps)
            kc = (vpasolve(equation, kcsym, axisLimits));
        else
            kc = (sqrt(vpasolve(equation, kcsquared, axisLimits.^2)));
        end
        digits(digitsOld);
    else
        close all
        fplot(real(lhsEquation),axisLimits)
        hold on
        fplot(real(rhsEquation),axisLimits);
        fplot(imag(rhsEquation),axisLimits);
        xlabel('k_c')
        ylabel('Equation')
        legend('LHS','RHS','Location','best')
        set(gca, 'fontsize', 22)
    end