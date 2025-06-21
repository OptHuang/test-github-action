function hp_tuning()
    
    % There are two hyperparameters to tune: theta and gamma.
    % They should satisfy the following conditions:
    %   0 < theta < 1
    %   gamma >= 1
    % The default values are theta = 0.5 and gamma = 2.
    % We define log_theta = log2(theta) and log_gamma = log2(gamma).
    % Thus the constraints become:
    %   log_theta < 0
    %   log_gamma >= 0
    % Then we use BOBYQA to solve this derivative-free bound-constrained optimization problem.

    mkdir hp_tuning;

    x0 = [-1; 1]; % Initial guess for log_theta and log_gamma
    lb = [-Inf; 0]; % Lower bounds for log_theta and log_gamma
    ub = [-eps; Inf]; % Upper bounds for log_theta and log_gamma
    bobyqa_options.maxfun = 100; % Maximum number of function evaluations

    % Tune the hyperparameters using BOBYQA
    [x, fx, exitflag, output] = bobyqa(@tuning_loss, x0, lb, ub, bobyqa_options);

    % Save the results from BOBYQA
    save('hp_tuning/results.mat', 'x', 'fx', 'exitflag', 'output');

    % Benchmark tuned PDS with the default PDS
    cd hp_tuning;
    theta = 2^x(1);
    gamma = 2^x(2);
    solvers = cell(1, 2);
    solvers{1} = @(fun, x0) pds(fun, x0, 0.5, 2);
    solvers{2} = @(fun, x0) pds(fun, x0, theta, gamma);
    options.ptype = 'u';
    options.maxdim = 5;
    options.solver_names = {'Default', 'Tuned'};
    benchmark(solvers, options)
    cd ..;
    mkdir archives;
    system('cp hp_tuning/out/*/detailed_profiles/perf_history-based/*_4.pdf hp_tuning/archives/tuning.pdf');
end

function f = tuning_loss(x)

    x0 = [-1; 1];
    if norm(x - x0) <= 1e-8
        f = 0;
        return;
    end
    theta = 2^x(1);
    gamma = 2^x(2);
    solvers = cell(1, 2);
    solvers{1} = @(fun, x0) pds(fun, x0, 0.5, 2);
    solvers{2} = @(fun, x0) pds(fun, x0, theta, gamma);
    options.ptype = 'u';
    options.maxdim = 5;
    options.score_fun = @(x) x(:, 4, 1, 1);
    options.solver_names = {'Default', 'Tuned'};
    options.benchmark_id = 'hp_tuning';

    scores = benchmark(solvers, options);
    f = scores(1) - scores(2);
end
