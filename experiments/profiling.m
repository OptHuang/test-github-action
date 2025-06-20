function profiling()

    mkdir profiling;
    cd profiling;

    solvers = {@newuoa, @fminsearch, @fminunc};
    options.solver_names = {'NEWUOA', 'simplex', 'BFGS'};
    options.plibs = {'s2mpj', 'matcutest'};
    options.ptype = 'u';
    options.maxdim = 30;
    options.max_eval_factor = 100;
    
    features = {'plain', 'noisy', 'perturbed_x0', 'truncated', 'linearly_transformed', 'random_nan'};
    for i = 1:length(features)
        options.feature_name = features{i};
        options.benchmark_id = features{i};
        benchmark(solvers, options);
        system(['../extract_pdfs.sh ', features{i}, ' archives/' features{i}]);
    end
end