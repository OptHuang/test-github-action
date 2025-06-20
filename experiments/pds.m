function [x, xhist, fhist] = pds(fun, x0, theta, gamma)

    c = 1e-3;
    a0 = 1;
    dim = length(x0);
    a = a0;
    maxfun = 1000;
    stepTol = 1e-8;

    s = RandStream('mt19937ar', 'Seed', 1);

    x = x0;
    fx = fun(x);
    xhist(:, 1) = x;
    fhist = fx;

    for k = 1:maxfun
        
        if a <= stepTol
            break;
        end

        d = s.randn(dim, 1);
        d = d ./ norm(d);

        success = false;

        x_trial = x + a * d;
        f_trial = fun(x_trial);
        xhist = [xhist, x_trial];
        fhist = [fhist, f_trial];

        if fx - f_trial >= c * a^2
            x = x_trial;
            fx = f_trial;
            success = true;
        else
            x_trial = x - a * d;
            f_trial = fun(x_trial);
            xhist = [xhist, x_trial];
            fhist = [fhist, f_trial];

            if fx - f_trial >= c * a^2
                x = x_trial;
                fx = f_trial;
                success = true;
            end
        end

        if success
            a = a * gamma;
        else
            a = a * theta;
        end

    end

end
