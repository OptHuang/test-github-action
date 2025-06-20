# OptiProfiler experiments

This repository contains the code for the experiments in the paper "OptiProfiler: A Benchmarking Platform for Optimization Solvers" by [Cunxin Huang](https://opthuang.github.io), [Tom M. Ragonneau](https://ragonneau.github.io), and [Zaikun Zhang](https://www.zhangzk.net/).

## Getting started

Before running experiments, please make sure you have completed the following preparations:

1. System and MATLAB Requirements
    - Operating System: Ubuntu 20.04 or later
    - MATLAB: Version R2021b or later
2. Install OptiProfiler

    Clone the repository:
    ```bash
    git clone --recurse-submodules https://github.com/optiprofiler/optiprofiler.git
    ```

    Then, in MATLAB, navigate to the root directory of the cloned OptiProfiler repository ``optiprofiler`` and run:
    ```matlab
    setup
    ```
3.  Install PRIMA

    Clone the PRIMA repository:
    ```bash
    git clone git@github.com:libprima/prima.git
    ```

    Then, in MATLAB, navigate to the root directory of the cloned PRIMA repository ``prima`` and run:
    ```matlab
    setup
    ```

## Profiling experiment

To run the profiling experiment, run the following command in MATLAB:

```matlab
profiling
```

This will create a directory called `profiling/archives` containing the PDFs used in the paper.

## Hyperparameter tuning experiment

To run the hyperparameter tuning experiment, run the following command in MATLAB:

```matlab
hp_tuning
```

This will create a directory called `hp_tuning/archives` containing the PDFs used in the paper.

> **Warning.** Both experiments take a long time to run.